/****************************************************************************
 * uvmdev_simple_mem.svh
 ****************************************************************************/

/**
 * Class: uvmdev_simple_mem
 * 
 * TODO: Add class documentation
 */
class uvmdev_simple_mem implements uvmdev_mem_if;
	local longint unsigned			m_addr_base;
	local longint unsigned			m_addr_limit;
	local bit						m_little_endian;
	local byte unsigned				m_data[];

	function new(
		longint unsigned			addr_base,
		longint unsigned			addr_limit,
		bit							little_endian=1);
		byte unsigned init_data[] = {'h0d, 'h0e, 'h0a, 'h0d, 'h0b, 'h0e, 'h0e, 'h0f};
		m_addr_base = addr_base;
		m_addr_limit = addr_limit;
		m_little_endian = little_endian;
		
		m_data = new[m_addr_limit-m_addr_base+1];
		
		for (int i=0; i<m_data.size(); i++) begin
			m_data[i] = init_data[i%init_data.size()];
		end
	endfunction
	
	virtual task read8(
			output byte unsigned		data,
			input longint unsigned		addr);
		if (addr >= m_addr_base && addr < m_addr_limit) begin
			data = m_data[addr-m_addr_base];
		end else begin
			`uvm_fatal("uvmdev_simple_mem", $sformatf("Access to out-of-bounds memory: 'h%08h", addr));
		end
	endtask
	
	virtual task read16(
			output shortint unsigned	data,
			input longint unsigned		addr);
	endtask
	
	virtual task read32(
			output int unsigned			data,
			input longint unsigned		addr);
	endtask
	
	virtual task write8(
			input byte unsigned			data,
			input longint unsigned		addr);
		if (addr >= m_addr_base && addr < m_addr_limit) begin
			m_data[addr-m_addr_base] = data;
		end else begin
			`uvm_fatal("uvmdev_simple_mem", $sformatf("Access to out-of-bounds memory: 'h%08h", addr));
		end
	endtask
	
	virtual task write16(
			input shortint unsigned		data,
			input longint unsigned		addr);
	endtask
	
	virtual task write32(
			input int unsigned			data,
			input longint unsigned		addr);
	endtask


endclass


