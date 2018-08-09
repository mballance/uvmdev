/****************************************************************************
 * uvmdev_if.svh
 ****************************************************************************/

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
	pure virtual task init();

endclass


