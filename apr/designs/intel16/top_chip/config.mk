export DESIGN_NAME = top_chip
export PLATFORM    = intel16

export CACHED_NETLIST 	= ../syn/$(DESIGN_NAME)/netlist/$(DESIGN_NAME).sv
export SDC_FILE      	= ../syn/$(DESIGN_NAME)/netlist/$(DESIGN_NAME).sdc

export ADDITIONAL_LEFS 	+= ../ip/memory/ip224uhdlp1p11rf_2048x32m8b2c1s0_t0r0p0d0a1m1h/lef/ip224uhdlp1p11rf_2048x32m8b2c1s0_t0r0p0d0a1m1h.lef
export ADDITIONAL_GDS	+= ../ip/memory/ip224uhdlp1p11rf_2048x32m8b2c1s0_t0r0p0d0a1m1h/gds/ip224uhdlp1p11rf_2048x32m8b2c1s0_t0r0p0d0a1m1h.gds

export PRS_FILL    = 1
export DIE_AREA    = 0 0 1962.36 2042.46
export CORE_AREA   = 16.2 17.64 1899.72 1979.46

export PLACE_DENSITY = uniform
export ABC_CLOCK_PERIOD_IN_PS = 1000