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
	`include "uvmdev_irq_if.svh"
	`include "uvmdev_isr_if.svh"
	`include "uvmdev_isr_base.svh"

endpackage


