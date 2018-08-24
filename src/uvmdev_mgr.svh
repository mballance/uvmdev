/****************************************************************************
 * uvmdev_mgr.svh
 ****************************************************************************/

typedef class uvmdev_if;

/**
 * Class: uvmdev_mgr
 * 
 * TODO: Add class documentation
 */
class uvmdev_mgr;
	static uvmdev_mgr		m_inst = new();
	uvmdev_if				m_devices[int unsigned];
	uvm_object				m_dev_data[int unsigned];
	uvmdev_mem_if			m_mem_if;

	function new();

	endfunction

	function void add_device(
		int unsigned		id,
		uvmdev_if			dev,
		uvm_object			dev_data);
		m_devices[id] = dev;
		m_dev_data[id] = dev_data;
	endfunction
	
	function uvmdev_if get_device(
		int unsigned		id);
		return m_devices[id];
	endfunction
	
	task init_devices();
		int unsigned idx;
		
		if (m_devices.first(idx)) begin
			do begin
				$display("--> Init %p", m_devices[idx]);
				m_devices[idx].init(this, idx);
				$display("<-- Init %p", m_devices[idx]);
			end while (m_devices.next(idx));
		end
	endtask
	
	function uvmdev_mem_if get_mem_if();
		return m_mem_if;
	endfunction
	
	function uvm_object get_dev_data(int unsigned id);
		return m_dev_data[id];
	endfunction
	
	static function uvmdev_mgr inst();
		return m_inst;
	endfunction
	
	static function uvmdev_if get(int unsigned id);
		return inst().get_device(id);
	endfunction
	
	static function void add(
		int unsigned 	id, 
		uvmdev_if 		dev,
		uvm_object		dev_data=null);
		inst().add_device(id, dev, dev_data);
	endfunction
	
	static task init();
		inst().init_devices();
	endtask
	
	static function void set_mem_if(uvmdev_mem_if mem_if);
		inst().m_mem_if = mem_if;
	endfunction

endclass


