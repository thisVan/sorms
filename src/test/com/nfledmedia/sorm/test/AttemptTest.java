package com.nfledmedia.sorm.test;

import java.util.ArrayList;
import java.util.List;


public class AttemptTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List lst = new ArrayList();
		lst.add("1");
		lst.add("1");
		lst.add("1");
		lst.add("1");
		lst.add("1");
		lst.add("1");
		
		lst.add(0, "0");
		
		System.out.println(lst.size());
		
		for (Object object : lst) {
			System.out.println(object);
		}
	}

}
