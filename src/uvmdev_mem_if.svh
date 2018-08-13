/****************************************************************************
 * uvmdev_mem_if.svh
 ****************************************************************************/

/**
 * Class: uvmdev_mem_if
 * 
 * TODO: Add class documentation
 */
interface class uvmdev_mem_if;

	pure virtual task read8(
			output byte unsigned		data,
			input longint unsigned		addr);
	
	pure virtual task read16(
			output shortint unsigned	data,
			input longint unsigned		addr);
	
	pure virtual task read32(
			output int unsigned			data,
			input longint unsigned		addr);
	
	pure virtual task write8(
			input byte unsigned			data,
			input longint unsigned		addr);
	
	pure virtual task write16(
			input shortint unsigned		data,
			input longint unsigned		addr);
	
	pure virtual task write32(
			input int unsigned			data,
			input longint unsigned		addr);

endclass


