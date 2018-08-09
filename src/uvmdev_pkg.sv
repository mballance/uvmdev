/****************************************************************************
 * uvmdev_pkg.sv
 ****************************************************************************/

`include "uvm_macros.svh"

/**
 * Package: uvmdev_pkg
 * 
 * TODO: Add package documentation
 */
package uvmdev_pkg;
	import uvm_pkg::*;

	`include "uvmdev_if.svh"
	`include "uvmdev_action_if.svh"
	`include "uvmdev_action_mgr_if.svh"
	`include "uvmdev_irq_if.svh"
	`include "uvmdev_isr_if.svh"
	`include "uvmdev_isr_base.svh"
	`include "uvmdev_mgr.svh"
	`include "uvmdev_action_mgr.svh"
	
	typedef int unsigned uint32_t;
	typedef shortint unsigned uint16_t;
	typedef byte unsigned uint8_t;

endpackage


