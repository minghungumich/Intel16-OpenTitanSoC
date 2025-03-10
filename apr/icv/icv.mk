
icv: icv_drc icv_antenna icv_density icv_layer icv_iopad icv_template icv_lvs

clean_icv: 
	rm -rf icv/drc && rm -rf icv/antenna && rm -rf icv/density && \
	rm -rf icv/layer && rm -rf icv/iopad && rm -rf icv/template && rm -rf icv/lvs

icv_drc:
	rm -rf icv/drc && mkdir -p icv/drc && cd icv/drc && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/drcd.rs

icv_antenna:
	rm -rf icv/antenna && mkdir -p icv/antenna && cd icv/antenna && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/drc_IPall.rs

icv_density:
	rm -rf icv/density && mkdir -p icv/density && cd icv/density && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/denall.rs

icv_layer:
	rm -rf icv/layer && mkdir -p icv/layer && cd icv/layer && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/drc_IL.rs

icv_iopad:
	rm -rf icv/iopad && mkdir -p icv/iopad && cd icv/iopad && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/drc_LU.rs

icv_template:
	rm -rf icv/template && mkdir -p icv/template && cd icv/template && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-I $(INTEL_PDK)/libraries/icv/libcells -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/drc_TUC.rs

icv_lvs:
	rm -rf icv/lvs && mkdir -p icv/lvs && cd icv/lvs && \
	icv -host_init 16 -D _drPROCESS=_drdotFour \
	-D _drSECTION_LEVEL=_drYES -D _drLAYERSTACK=$(LAYERSTACK) \
	-c $(DR_DESIGN_NAME) -i $(DR_INPUT_FILE) -f $(DR_INPUT_FILE_FORMAT) -vue \
	-norscache -sf spice -s $(DR_SCH_FILE) \
	-I $(INTEL_PDK)/libraries/icv/libcells -I . -I $(INTEL_RUNSETS) \
	-I $(INTEL_RUNSETS)/PXL $(INTEL_RUNSETS)/PXL/StandAlone/trclvs.rs

view_icv_drc:
	icvwb $(DR_INPUT_FILE) -vue icv/drc/$(DR_DESIGN_NAME).vue

view_icv_antenna:
	icvwb $(DR_INPUT_FILE) -vue icv/antenna/$(DR_DESIGN_NAME).vue

view_icv_density:
	icvwb $(DR_INPUT_FILE) -vue icv/density/$(DR_DESIGN_NAME).vue

view_icv_layer:
	icvwb $(DR_INPUT_FILE) -vue icv/layer/$(DR_DESIGN_NAME).vue

view_icv_iopad:
	icvwb $(DR_INPUT_FILE) -vue icv/iopad/$(DR_DESIGN_NAME).vue

view_icv_template:
	icvwb $(DR_INPUT_FILE) -vue icv/template/$(DR_DESIGN_NAME).vue

view_icv_lvs:
	icvwb $(DR_INPUT_FILE) -vue icv/lvs/$(DR_DESIGN_NAME).vue