/****************************************************************************
 * uvmdev_action_if.svh
 ****************************************************************************/

class uvmdev_action_mgr_if;
	
/**
 * Class: uvmdev_action_if
 * 
 * Interface to a uvmdev action, which is effectively a closure
 */
interface class uvmdev_action_if;

	/**
	 * Task: run
	 * 
	 * Called to run the behavior of the action. 
	 * 
	 * Parameters:
	 */
	pure virtual task run();
	

endclass


