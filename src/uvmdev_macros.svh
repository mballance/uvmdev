/****************************************************************************
 * uvmdev_macros.svh
 ****************************************************************************/
`ifndef INCLUDED_UVMDEV_MACROS_SVH
`define INCLUDED_UVMDEV_MACROS_SVH

`define uvmdev_call(devtype, id, call) \
	begin \
		uvmdev_if d = uvmdev_mgr::get(id); \
		devtype dev; \
		if (!$cast(dev, d)) begin \
			uvm_object o; \
			$cast(o, d); \
			$display("Error: device %0d is not of correct type ; expect=%0s received=%0s", \
				id, `"devtype`", o.get_type_name()); \
		end else begin \
			dev . call ; \
		end \
	end
	
`define uvmdev_task_decl_0(devtype, fname) \
	task automatic devtype``_``fname (uint32_t id); \
		`uvmdev_call(devtype, id, fname()); \
	endtask
	
`define uvmdev_task_decl_1(devtype, fname, t1) \
	task automatic devtype``_``fname (uint32_t id, t1 p1); \
		`uvmdev_call(devtype, id, fname(p1)); \
	endtask
	
`define uvmdev_task_decl_2(devtype, fname, t1, t2) \
	task automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2); \
		`uvmdev_call(devtype, id, fname(p1, p2)); \
	endtask
	
`define uvmdev_task_decl_3(devtype, fname, t1, t2, t3) \
	task automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3); \
		`uvmdev_call(devtype, id, fname(p1, p2, p3)); \
	endtask
	
`define uvmdev_task_decl_4(devtype, fname, t1, t2, t3, t4) \
	task automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3, t4 p4); \
		`uvmdev_call(devtype, id, fname(p1, p2, p3, p4)); \
	endtask
	
`define uvmdev_task_decl_5(devtype, fname, t1, t2, t3, t4, t5) \
	task automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3, t4 p4, t5 p5); \
		`uvmdev_call(devtype, id, fname(p1, p2, p3, p4, p5)); \
	endtask

`define uvmdev_function_decl_0(devtype, fname) \
	function automatic devtype``_``fname (uint32_t id); \
			`uvmdev_call(devtype, id, fname()); \
	endfunction
	
`define uvmdev_function_decl_1(devtype, fname, t1) \
	function automatic devtype``_``fname (uint32_t id, t1 p1); \
			`uvmdev_call(devtype, id, fname(p1)); \
	endfunction
	
`define uvmdev_function_decl_2(devtype, fname, t1, t2) \
	function automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2); \
			`uvmdev_call(devtype, id, fname(p1, p2)); \
	endfunction
	
`define uvmdev_function_decl_3(devtype, fname, t1, t2, t3) \
	function automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3); \
			`uvmdev_call(devtype, id, fname(p1, p2, p3)); \
	endfunction
	
`define uvmdev_function_decl_4(devtype, fname, t1, t2, t3, t4) \
	function automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3, t4 p4); \
			`uvmdev_call(devtype, id, fname(p1, p2, p3, p4)); \
	endfunction
	
`define uvmdev_function_decl_5(devtype, fname, t1, t2, t3, t4, t5) \
	function automatic devtype``_``fname (uint32_t id, t1 p1, t2 p2, t3 p3, t4 p4, t5 p5); \
			`uvmdev_call(devtype, id, fname(p1, p2, p3, p4, p5)); \
	endfunction	
/**
 * Convenience macro for referring to the closure
 */
`define uvmdev_closure(devtype, fname) uvmdev_closure_``devtype``_``fname
	
`define uvmdev_closure_spawn(devtype, fname, args) \
	uvmdev_closure_``devtype``_``fname :: spawn args ;
	
`define uvmdev_closure_decl_1(devtype, fname, t1) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1); \
			this.devid = devid; \
			this.p1 = p1; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1); \
			end \
		endtask \
		\
		static task spawn( \
			uvmdev_closure_``devtype``_``fname action = new args ; \
		endtask \
	endclass
	
`define uvmdev_closure_decl_2(devtype, fname, t1, t2) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2); \
		endtask \
	endclass
	
`define uvmdev_closure_decl_3(devtype, fname, t1, t2, t3) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		t3				p3; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2, \
			t3				     p3);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			this.p3 = p3; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2, p3); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2, t3 p3); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2, p3); \
		endtask \
	endclass
	
	
`define uvmdev_closure_decl_4(devtype, fname, t1, t2, t3, t4) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		t3				p3; \
		t4				p4; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2, \
			t3				     p3, \
			t4				     p4);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			this.p3 = p3; \
			this.p4 = p4; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2, p3, p4); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2, t3 p3, t4 p4); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2, p3, p4); \
		endtask \
	endclass
	
`define uvmdev_closure_decl_5(devtype, fname, t1, t2, t3, t4, t5) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		t3				p3; \
		t4				p4; \
		t5				p5; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2, \
			t3				     p3, \
			t4				     p4, \
			t5				     p5);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			this.p3 = p3; \
			this.p4 = p4; \
			this.p5 = p5; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2, p3, p4, p5); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2, t3 p3, t4 p4, t5 p5); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2, p3, p4, p5); \
		endtask \
	endclass
	
`define uvmdev_closure_decl_6(devtype, fname, t1, t2, t3, t4, t5, t6) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		t3				p3; \
		t4				p4; \
		t5				p5; \
		t6				p6; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2, \
			t3				     p3, \
			t4				     p4, \
			t5				     p5, \
			t6				     p6);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			this.p3 = p3; \
			this.p4 = p4; \
			this.p5 = p5; \
			this.p6 = p6; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2, p3, p4, p5, p6); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2, t3 p3, t4 p4, t5 p5, t6 p6); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2, p3, p4, p5, p6); \
		endtask \
	endclass
	
`define uvmdev_closure_decl_7(devtype, fname, t1, t2, t3, t4, t5, t6, t7) \
	class uvmdev_closure_``devtype``_``fname implements uvmdev_action_if; \
		int	unsigned	devid; \
		t1				p1; \
		t2				p2; \
		t3				p3; \
		t4				p4; \
		t5				p5; \
		t6				p6; \
		t7				p7; \
		\
		function new( \
			uvmdev_action_mgr_if mgr, \
			int unsigned	     devid, \
			t1				     p1, \
			t2				     p2, \
			t3				     p3, \
			t4				     p4, \
			t5				     p5, \
			t6				     p6, \
			t7				     p7);\
			this.devid = devid; \
			this.p1 = p1; \
			this.p2 = p2; \
			this.p3 = p3; \
			this.p4 = p4; \
			this.p5 = p5; \
			this.p6 = p6; \
			this.p7 = p7; \
			mgr.spawn(this); \
		endfunction \
		\
		virtual task run(); \
			uvmdev_if d = uvmdev_mgr::get(devid); \
			devtype dev; \
			\
			if (!$cast(dev, d)) begin \
				$display("Error: device %0d is not of the correct type", devid); \
			end else begin \
				dev . fname (p1, p2, p3, p4, p5, p6, p7); \
			end \
		endtask \
		\
		static task spawn(\
			uvmdev_action_mgr_if   mgr,   \
			uint32_t               devid, \
			t1 p1, t2 p2, t3 p3, t4 p4, t5 p5, t6 p6, t7 p7); \
		  uvmdev_closure_``devtype``_``fname action = new (mgr, devid, p1, p2, p3, p4, p5, p6, p7); \
		endtask \
	endclass
	
	
	
`endif /* INCLUDED_UVMDEV_MACROS_SVH */
