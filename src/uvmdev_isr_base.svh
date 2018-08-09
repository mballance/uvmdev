/****************************************************************************
 * uvmdev_isr_base.svh
 ****************************************************************************/

typedef class uvmdev_irq_if;

/**
 * Class: uvmdev_isr_base
 * 
 * Utility base class for ISR implementations
 */
virtual class uvmdev_isr_base #(type T=int) extends uvm_subscriber #(T) implements uvmdev_isr_if;
	`uvm_component_utils(uvmdev_isr_base)

	uvmdev_irq_if					m_listeners[];
	int unsigned					m_dev_irq[];
	
	function new(string	name="uvmdev_isr_base", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void init(int unsigned n_irqs);
		m_listeners = new[n_irqs];
		m_dev_irq = new[n_irqs];
	endfunction
	
	virtual task send_irq(int unsigned irq);
		if (m_listeners.size > irq) begin
			if (m_listeners[irq] != null) begin
				m_listeners[irq].irq(m_dev_irq[irq]);
			end else begin
				`uvm_warning(get_name(), $sformatf("No listener for IRQ %0d", irq));
			end
		end else begin
			`uvm_fatal(get_name(), $sformatf("IRQ %0d outside the range of %0d",
					irq, m_listeners.size()));
		end
	endtask

	/**
	 * Function: set_irq_listener
	 * 
	 * Connects an interrupt-request listener to a 
	 * specific irq slot.
	 * 
	 * Parameters:
	 * - int irq 
	 * - uvmdev_irq_if irq_if 
	 * - int dev_irq 
	 * 
	 * Returns:
	 *   void
	 */
	virtual function void set_irq_listener(
			int unsigned 	irq,
			uvmdev_irq_if 	irq_if,
			int unsigned 	dev_irq=0);
		m_listeners[irq] = irq_if;
		m_dev_irq[irq] = dev_irq;
	endfunction

endclass


