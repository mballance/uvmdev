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

	function new();

	endfunction

	function void add_device(
		int unsigned		id,
		uvmdev_if			dev);
		m_devices[id] = dev;
	endfunction
	
	function uvmdev_if get_device(
		int unsigned		id);
		return m_devices[id];
	endfunction
	
	static function uvmdev_mgr inst();
		return m_inst;
	endfunction
	
	static function uvmdev_if get(int unsigned id);
		return inst().get_device(id);
	endfunction

endclass


