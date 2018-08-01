/****************************************************************************
 * uvmdev_action_mgr.svh
 ****************************************************************************/

/**
 * Class: uvmdev_action_mgr
 * 
 * TODO: Add class documentation
 */
class uvmdev_action_mgr extends uvm_object implements uvmdev_action_mgr_if;
	`uvm_object_utils(uvmdev_action_mgr);
	
	local event					m_action_started_ev;
	local event					m_action_ended_ev;
	
	// Field: m_active_map
	// Map of active actions to a status whether they have started
	local bit					m_active_map[uvmdev_action_if];

	function new(string name="uvmdev_action_mgr");
		super.new(name);
	endfunction
	
	virtual function void action_started(uvmdev_action_if a);
		m_active_map[a] = 1;
		-> m_action_started_ev;
	endfunction
	
	virtual function void action_ended(uvmdev_action_if a);
		m_active_map.delete(a);
		-> m_action_ended_ev;
	endfunction
	
	virtual function void spawn(uvmdev_action_if a);
		m_active_map[a] = 0;
		fork
			begin
				action_started(a);
				a.run();
				action_ended(a);
			end
		join_none
	endfunction

	/**
	 * Task: await
	 * 
	 * Wait for all active actions to complete
	 * 
	 * Parameters:
	 */
	virtual task await();
		while (m_active_map.size() > 0) begin
			
			@(m_action_ended_ev);
		end
	endtask

endclass


