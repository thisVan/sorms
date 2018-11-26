package com.nfledmedia.sorm.util;

import java.util.Arrays;
import java.util.Date;

public class MergeSort {

	public static void main(String[] args) {
		int n = 100000000;
		int original[] = new int[n];
		for (int i = 0; i < n; i++) {
			original[i] = (int) (Math.random() * n);
		}
		Date dateStart = new Date();
		mergeSort(original);
		Date dateEnd = new Date();
		System.out.println(dateEnd.getTime() - dateStart.getTime());
//		print(original);
	}

    private static void mergeSort(int[] original) {
        if (original == null) {
            throw new NullPointerException("The array can not be null !!!");
        }
        int length = original.length;
        if (length > 1) {
            int middle = length / 2;
            int partitionA[] = Arrays.copyOfRange(original, 0, middle);// 拆分问题规模
            int partitionB[] = Arrays.copyOfRange(original, middle, length);
            // 递归调用
            mergeSort(partitionA);
            mergeSort(partitionB);
            sort(partitionA, partitionB, original);
        }
    }

    private static void sort(int[] partitionA, int[] partitionB, int[] original) {
        int i = 0;
        int j = 0;
        int k = 0;
        while (i < partitionA.length && j < partitionB.length) {
            if (partitionA[i] <= partitionB[j]) {
                original[k] = partitionA[i];
                i++;
            } else {
                original[k] = partitionB[j];
                j++;
            }
            k++;
        }
        if (i == partitionA.length) {
            while (k < original.length) {
                original[k] = partitionB[j];
                k++;
                j++;
            }
        } else if (j == partitionB.length) {
            while (k < original.length) {
                original[k] = partitionA[i];
                k++;
                i++;
            }
        }
    }

    private static void print(int[] array) {
        if (array == null) {
            throw new NullPointerException("The array can not be null !!!");
        }
        StringBuilder sb = new StringBuilder("[");
        for (int element : array) {
            sb.append(element + ", ");
        }
        sb.replace(sb.length() - 2, sb.length(), "]");
        System.out.println(sb.toString());
    }
}
