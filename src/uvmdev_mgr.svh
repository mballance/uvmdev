/****************************************************************************
 * uvmdev_mgr.svh
 ****************************************************************************/

typedef class uvmdev_if;

/**
 * Class: uvmdev_mgr
 * 
 * TODO: Add class documentation
 */
class uvmdev_mgr extends uvm_component;
	`uvm_component_utils(uvmdev_mgr)
	
	static uvmdev_mgr		m_inst = null;
	uvmdev_if				m_devices[int unsigned];
	uvm_object				m_dev_data[int unsigned];
	uvmdev_mem_if			m_mem_if;
	uvm_phase				m_run_phase;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		m_inst = this;
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
		if (m_devices.exists(id)) begin
			return m_devices[id];
		end else begin
			return null;
		end
	endfunction
	
	function void raise_objection(uvm_object obj, string description="", int count=1);
		if (m_run_phase != null) begin
//			`uvm_info(get_name(), $sformatf("== raise_objection %0s %p", description,
//					m_run_phase.get_objection()), UVM_LOW);
//			m_run_phase.raise_objection(this, description, count);
		end else begin
			`uvm_fatal("uvmdev_mgr", "Attempting to raise an objection on a null handle");
		end
	endfunction
	
	function void drop_objection(uvm_object obj, string description="", int count=1);
		if (m_run_phase != null) begin
//			`uvm_info(get_name(), $sformatf("== drop_objection %0s %p", description,
//					m_run_phase.get_objection()), UVM_LOW);
//			m_run_phase.drop_objection(this, description, count);
		end else begin
			`uvm_fatal("uvmdev_mgr", "Attempting to drop an objection on a null handle");
		end
	endfunction
	
	task init_devices();
		int unsigned idx;
		
		if (m_devices.first(idx)) begin
			do begin
				m_devices[idx].init(this, idx);
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
		if (m_inst == null) begin
			$display("FATAL: uvmdev_mgr has not been instanced");
		end
		return m_inst;
	endfunction
	
	task run_phase(uvm_phase phase);
		m_run_phase = phase;
	endtask
	
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
	
	function void set_mem_if(uvmdev_mem_if mem_if);
		m_mem_if = mem_if;
	endfunction

endclass
task automatic pvm_iowrite8(byte unsigned data, longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.write8(data, addr);
endtask

task automatic pvm_ioread8(output byte unsigned data, input longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.read8(data, addr);
endtask

task automatic pvm_iowrite16(shortint unsigned data, longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.write16(data, addr);
endtask

task automatic pvm_ioread16(output shortint unsigned data, input longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.read16(data, addr);
endtask

task automatic pvm_iowrite32(int unsigned data, longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.write32(data, addr);
endtask

task automatic pvm_ioread32(output int unsigned data, input longint unsigned addr);
	uvmdev_mgr mgr = uvmdev_mgr::inst();
	
	mgr.m_mem_if.read32(data, addr);
endtask



