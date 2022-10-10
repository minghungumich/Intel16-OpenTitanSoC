// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// tl_only_instr package generated by `tlgen.py` tool

package tl_only_instr_pkg;

  localparam logic [31:0] ADDR_SPACE_INSTR = 32'h 00000000;
  localparam logic [31:0] ADDR_SPACE_DATA  = 32'h 20000000;

  localparam logic [31:0] ADDR_MASK_INSTR = 32'h 0fffffff;
  localparam logic [31:0] ADDR_MASK_DATA  = 32'h 0fffffff;

  localparam int N_HOST   = 2;
  localparam int N_DEVICE = 2;

  typedef enum int {
    TlInstr = 0,
    TlData = 1
  } tl_device_e;

  typedef enum int {
    TlCoreInst = 0,
    TlCoreData = 1
  } tl_host_e;

endpackage