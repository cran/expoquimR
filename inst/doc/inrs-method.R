## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)
library(expoquimR)

## ----peligro------------------------------------------------------------------
# From H phrases
inrs_hazard_class(h_phrases = "H336")

# From VLA
inrs_hazard_class(vla = 0.05)   # <= 0.1 mg/m³ → class 5
inrs_hazard_class(vla = 50)     # > 10 mg/m³   → class 1 (default)

## ----cantidad_frecuencia------------------------------------------------------
inrs_quantity_class(5, "l")          # 5 litres → class 2
inrs_frequency_class(3, "hours")    # 3 hours/day → class 3

## ----exposicion---------------------------------------------------------------
inrs_potential_exposure_class("2", "3")   # → class 2
inrs_potential_risk_score("2")        # → 10

## ----volatilidad--------------------------------------------------------------
# From boiling point graph (official INRS Figure 2)
inrs_liquid_volatility_graph(use_temperature = 20, boiling_point = 111)

# From vapour pressure (Table 8 thresholds: 0.5 kPa / 25 kPa)
inrs_liquid_volatility_pressure(vapour_pressure = 5)

## ----pulverulencia------------------------------------------------------------
inrs_solid_dustiness("Fine dust with little visible dispersion")

## ----proceso_proteccion-------------------------------------------------------
inrs_process_type("Open")
inrs_collective_protection("Moderate dispersion conditions")

## ----vla_correction_factor----------------------------------------------------
inrs_oel_correction_factor(vla = 50)    # VLA > 0.1 → FC = 1
inrs_oel_correction_factor(vla = 0.05)  # VLA <= 0.1 → FC = 10

## ----riesgo-------------------------------------------------------------------
inrs_inhalation_risk(
  potential_risk_score  = 10,
  volatility_score      = 10,
  procedure_score       = 0.5,
  protection_score      = 0.7,
  vla_correction_factor = 1
)

## ----caracterizacion----------------------------------------------------------
inrs_risk_characterisation(35)
inrs_risk_characterisation(500)
inrs_risk_characterisation(5000)

## ----full---------------------------------------------------------------------
inrs_evaluate(
  name             = "Toluene",
  h_phrases        = "H336",
  vla              = 50,
  quantity_value   = 5,
  quantity_unit    = "l",
  frequency_value  = 3,
  frequency_unit   = "hours",
  substance_type   = "liquid",
  liquid_method    = "graph",
  use_temperature  = 20,
  boiling_point    = 111,
  procedure        = "Open",
  protection       = "Moderate dispersion conditions"
)

## ----excel, eval = FALSE------------------------------------------------------
# ruta <- system.file("plantillas", "plantilla_inrs.xlsx", package = "expoquimR")
# inrs_from_excel(ruta)

## ----language-----------------------------------------------------------------
expoquimr_lang("es")
inrs_risk_characterisation(35)
inrs_risk_characterisation(5000)
expoquimr_lang("en")

## ----app, eval = FALSE--------------------------------------------------------
# run_inrs()

