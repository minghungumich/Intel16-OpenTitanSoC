# Workspace and environment seup
# --------------------------------
export INTEL_KITS_DIR 	:= /afs/eecs.umich.edu/kits/Intel/P1222.4/2022.08
export INTEL_ASIC		:= $(INTEL_KITS_DIR)/adf224_r0.9HP1_s
export LAYERSTACK 		:= m11_1x_3xa_1xb_1xc_2yb_2ga_mim2_1gb__bumpp
export INTEL_PDK  		:= $(INTEL_KITS_DIR)/pdk224_r0.9HP3
export INTEL_STDCELLS	:= $(INTEL_KITS_DIR)/lib224_b0m_6t_108pp_pdk090_r1v0p0_fv
export INTEL_TIC 		:= $(INTEL_KITS_DIR)/pdk224_r0.9HP3
export SYN_TCL_DIR 		:= $(INTEL_ASIC)/asicflows/synopsys/syn
export STD_TCL_DIR 		:= $(INTEL_ASIC)/asicflows/synopsys/tech.dot4.6t108.tp0

# Design parameters
# --------------------------------
export DESIGN_NAME 		:= chip_earlgrey

# Synthesis-reltaed targets
# --------------------------------
all: dc netlist

dc:
	cd $(DESIGN_NAME) && \
	dc_shell -64 -topo -x	\
	"source $(STD_TCL_DIR)/tech_config.tcl; \
	source $(SYN_TCL_DIR)/run.tcl; \
	runADF; \
	exit"

check:
	cd $(DESIGN_NAME) && \
	dc_shell -64 -topo -x	\
	"source $(STD_TCL_DIR)/tech_config.tcl; \
	source $(SYN_TCL_DIR)/run.tcl; \
	runADF -stop read_constraints; \
	exit"

netlist:
	cd $(DESIGN_NAME) && rm -rf netlist && mkdir netlist && \
	cp outputs/$(DESIGN_NAME).syn.vg netlist/$(DESIGN_NAME).sv && \
	cp outputs/$(DESIGN_NAME).syn.FUNC_WORST.sdc netlist/$(DESIGN_NAME).sdc

clean:
	rm -rf $(DESIGN_NAME)/ddc 
	rm -rf $(DESIGN_NAME)/logs 
	rm -rf $(DESIGN_NAME)/mwdb 
	rm -rf $(DESIGN_NAME)/outputs 
	rm -rf $(DESIGN_NAME)/reports 
	rm -rf $(DESIGN_NAME)/synopsys_cache 
	rm -rf $(DESIGN_NAME)/alib-52 
	rm -rf $(DESIGN_NAME)/WORK
	rm -rf $(DESIGN_NAME)/.nfs* 
	rm -rf $(DESIGN_NAME)/*.svf 
	rm -rf $(DESIGN_NAME)/.*tcl
	rm -rf $(DESIGN_NAME)/*.log
	rm -rf $(DESIGN_NAME)/udul_default_fin*

nuke: clean