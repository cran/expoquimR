## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)
library(expoquimR)

## ----volatility---------------------------------------------------------------
# Toluene: boiling point 111 °C, process temperature 20 °C
coshh_classify_volatility(boiling_point = 111, process_temp = 20)

## ----grade--------------------------------------------------------------------
# Toluene: H315 (skin irritation), H336 (drowsiness/dizziness)
coshh_grade("H315, H336")

## ----risk---------------------------------------------------------------------
coshh_risk(grade = "A", quantity = "Medium", volatility = "Medium")

## ----measures-----------------------------------------------------------------
coshh_measures(1)

## ----full---------------------------------------------------------------------
coshh_evaluate(
  name          = "Toluene",
  phrases       = "H315, H336",
  quantity      = "Medium",
  is_liquid     = TRUE,
  boiling_point = 111,
  process_temp  = 20
)

## ----batch--------------------------------------------------------------------
substances <- list(
  list(name = "Toluene",  phrases = "H315, H336", quantity = "Medium",
       is_liquid = TRUE,  boiling_point = 111, process_temp = 20),
  list(name = "Xylene",   phrases = "H315, H336", quantity = "Large",
       is_liquid = TRUE,  boiling_point = 139, process_temp = 20),
  list(name = "Cement",   phrases = "H315",        quantity = "Large",
       is_liquid = FALSE, dustiness = "High")
)

results <- do.call(rbind, lapply(substances, function(s) {
  do.call(coshh_evaluate, s)
}))

results

## ----excel, eval = FALSE------------------------------------------------------
# # Access the built-in template
# ruta <- system.file("plantillas", "plantilla_coshh.xlsx", package = "expoquimR")
# 
# # Or copy it to your working directory
# file.copy(ruta, ".")
# 
# # Run the assessment
# coshh_from_excel("plantilla_coshh.xlsx")

## ----language-----------------------------------------------------------------
expoquimr_lang("es")

coshh_evaluate(
  name          = "Tolueno",
  phrases       = "H315, H336",
  quantity      = "Mediana",
  is_liquid     = TRUE,
  boiling_point = 111,
  process_temp  = 20
)

expoquimr_lang("en")  # reset to English

## ----app, eval = FALSE--------------------------------------------------------
# run_coshh()

