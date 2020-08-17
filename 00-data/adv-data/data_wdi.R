library(WDI)
library(countrycode)

library(here)

paises_americanos_iso2c <- treaties$country_name %>% 
  unique %>% 
  countrycode(origin = "country.name.en", destination = "iso2c")

paises_americanos_iso3c <- paises_americanos_iso2c %>% 
  unique() %>% 
  countrycode(origin = "iso2c", destination = "iso3c")

gdp_paises_americanos <- WDI(country = paises_americanos_iso2c, 
                             indicator = "NY.GDP.PCAP.PP.KD", 
                             start = 1996, end = 1998)

gdp_paises_americanos2 <- gdp_paises_americanos %>% 
  mutate(country_name = countrycode(iso2c, "iso2c", "country.name.en")) %>% 
  select(country_name, year, gdp_pc_ppp = NY.GDP.PCAP.PP.KD) %>% 
  arrange(country_name, year) %>% 
  as_tibble()

write_rds(gdp_paises_americanos2, "00-data/adv-data/americas_gdp_panel.rds")

base_cs <- haven::read_dta("~/Desktop/df_ua_tratado_participante_2.dta")

base_cs2 <- base_cs %>% 
  select(title, participant, date_of_conclusion, year, country, ccode)

v_tratados <- treaties$treaty_name %>% unique()

base_cs <- read_csv("00-data/adv-data/10_o_df_final_un_treaties_dates.csv") %>% 
  mutate(adoption_year = as.numeric(lubridate::year(date)),
         action_year   = as.numeric(lubridate::year(sign_date))) %>% 
  select(treaty_name = title, adoption_year, 
         country_name = country_iso_name, 
         country_iso3c,
         action_type = sign_type, action_year)

base_cs2 <- base_cs %>% 
  filter(country_iso3c %in% paises_americanos_iso3c) %>% 
  select(-country_iso3c) %>% 
  filter(treaty_name %in% v_tratados | 
           treaty_name %in% c(
             "Kyoto Protocol to the United Nations Framework Convention on Climate Change",
             "Rotterdam Convention on the Prior Informed Consent Procedure for Certain Hazardous Chemicals and Pesticides in International Trade"
           )) %>% 
  complete(treaty_name, country_name, action_type,
           fill = list(action_date = NA)) %>% 
  filter(action_type %in% c("Signature", "Ratification")) %>%
  select(-adoption_year) %>% 
  left_join(base_cs %>% 
              select(treaty_name, adoption_year) %>%  
              distinct(treaty_name, adoption_year)) %>% 
  select(treaty_name, adoption_year, country_name, action_type, action_year) %>% 
  arrange(adoption_year, treaty_name, country_name)

write_rds(base_cs2, "00-data/adv-data/treaties.rds")

View(base_cs2)
