/****************************************************************************
 * uvmdev_action_mgr_if.svh
 ****************************************************************************/

/**
 * Class: uvmdev_action_mgr_if
 * 
 * TODO: Add class documentation
 */
interface class uvmdev_action_mgr_if;

	pure virtual function action_started(uvmdev_action_if a);
	
	pure virtual function action_ended(uvmdev_action_if a);
	
	pure virtual function spawn(uvmdev_action_if a);

	/**
	 * Task: await
	 * 
	 * Wait for all active actions to complete
	 * 
	 * Parameters:
	 */
	pure virtual task await();


endclass


