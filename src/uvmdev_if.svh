/****************************************************************************
 * uvmdev_if.svh
 ****************************************************************************/

typedef class uvmdev_mgr;

/**
 * Class: uvmdev_if
 * 
 * TODO: Add class documentation
 */
interface class uvmdev_if;

	/**
	 * Task: init
	 * 
	 * Initializes the device by programming registers, etc
	 * 
	 * Parameters:
	 */
	pure virtual task init(
			uvmdev_mgr 		mgr, 
			int unsigned 	id);

endclass


