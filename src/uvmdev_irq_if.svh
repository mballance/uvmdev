/****************************************************************************
 * uvmdev_irq_if.svh
 ****************************************************************************/

/**
 * Class: uvmdev_irq_if
 * 
 * Classes that implement this interface are able to receive interrupts
 * from the ISR
 */
interface class uvmdev_irq_if;

	/**
	 * Task: irq
	 * 
	 * Called when an interrupt occurs
	 * 
	 * Parameters:
	 * - int id 
	 */
	pure virtual task irq(int unsigned id);


endclass


