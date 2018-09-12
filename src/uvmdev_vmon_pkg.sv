/****************************************************************************
 * uvmdev_vmon_pkg.sv
 ****************************************************************************/

/**
 * Package: uvmdev_vmon_pkg
 * 
 * TODO: Add package documentation
 */
package uvmdev_vmon_pkg;
	import uvm_pkg::*;
	import uvmdev_pkg::*;
	import vmon_client_pkg::*;
	
	class uvmdev_vmon_ep_client implements vmon_client_ep_if;
		
		virtual function void process_msg(byte unsigned ep, vmon_databuf data);
			int unsigned devid = data.get32();
			uvmdev_if dev = uvmdev_mgr::get(devid);
			vmon_client_ep_if ep_dev;
	
			if (dev != null) begin
				if ($cast(ep_dev, dev)) begin
					// Pass the remainder of the message on to the endpoint
					ep_dev.process_msg(ep, data);
				end else begin
					$display("Error: device %0d is not a vmon endpoint", devid);
				end
			end else begin
				$display("Error: device %0d is null", devid);
			end
		endfunction
		
	endclass


endpackage


