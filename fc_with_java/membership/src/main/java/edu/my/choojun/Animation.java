package edu.my.choojun;

import java.io.FileReader;

import net.sourceforge.jFuzzyLogic.FIS;
import net.sourceforge.jFuzzyLogic.plot.JDialogFis;
import net.sourceforge.jFuzzyLogic.plot.JFuzzyChart;

public class Animation {
	public static void main(String args[]) throws Exception {
		System.out.println("Start: Animation");

		// Load FCL file
		FileReader fr = new FileReader("conf/product.fcl");
		int i;
		StringBuffer sb = new StringBuffer();
		while ((i = fr.read()) != -1)
			sb.append((char) i);
		fr.close();
		fr = null;

		// Create FCL system
		String fcl = sb.toString();
		FIS fis = FIS.createFromString(fcl, true);
		System.out.println(fis);

		// Create a plot
		JDialogFis jdf = null;
		if (!JFuzzyChart.UseMockClass)
			jdf = new JDialogFis(fis, 800, 600);

		// Set different values for 'marketSegmentation' and 'productQuality'.
		// Evaluate the system and show variables
		for (double productQuality = 0.0, marketSegmentation = 1; productQuality <= 9; productQuality += 0.1) {
			marketSegmentation = productQuality;
			// Evaluate system using these parameters
			fis.getVariable("productQuality").setValue(productQuality);
			fis.getVariable("marketSegmentation").setValue(marketSegmentation);
			fis.evaluate();

			// Print result & update plot
			System.out.println(String.format(
					"productQuality: %2.2f" + "\tmarketSegmentation:%2.2f" + "\t=> sellingPrice: %2.2f %%",
					productQuality, marketSegmentation, fis.getVariable("sellingPrice").getValue()));
			if (jdf != null)
				jdf.repaint();

			// Small delay
			Thread.sleep(100);
		}

		System.out.println("End: Animation");
	}

	/**
	 * Round a double to an integer (time 100)
	 */
	static int doubleToInt100(double d) {
		return ((int) Math.round(d * 100));
	}

	static double int100ToDOuble(int i) {
		return (i) / 100.0;
	}
}
