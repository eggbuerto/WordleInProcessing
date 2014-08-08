/*
 * Evan Gould
 * CS5630
 * This class counts the words in a text file or text field and assigns each
 * word a weight based on how many times it appears in the text. It then sorts
 * the words based on weights and creates two separate arrays with words and weights
 * in the same order.
 */
//package finalproject;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;


public class WordleMap {
	
	//Map that will hold all the words in a text file and their weights
	private HashMap<String, Integer> wordMap;
	
	//size of the hashmap
	int size; 
	public String text[];
	public int weights[];

	public WordleMap(String filename)
	{
		
		wordMap = new HashMap<String, Integer>();
		try {
				//File fileName = new File(filename);
		      
		      Scanner file = new Scanner(filename);

		      //Ignore all punctuation
		      file.useDelimiter("\\s*[^a-zA-Z]\\s*");

		      while (file.hasNext()) {
		        String s = file.next().toLowerCase();
		        if (!s.equals("")) {
                           //check for common words
                           if (s.equals("the") || s.equals("and") || s.equals("s") || s.equals("an") || s.equals("to") || s.equals("of") || s.equals("in") || s.equals("a") || s.equals("as") 
                                 || s.equals("is") || s.equals("for") || s.equals("by") || s.equals("on") || s.equals("that") || s.equals("it") || s.equals("so") || s.equals("with")
                                 || s.equals("with") || s.equals("are") || s.equals("or") || s.equals("that") || s.equals("but") || s.equals("its") || s.equals("it") || s.equals("it's")
                                 || s.equals("at"))
                               continue;
		          //words.add(s.toLowerCase());
		        	//If the file is already in the set
		        	if (wordMap.containsKey(s))
		        	{
		        		//Increment that key's weight
		        		int value = wordMap.get(s); // get the value
		        		
		        		//Remove the value and put it back with an increased weight
		        		wordMap.remove(s);
		        		wordMap.put(s, ++value);
		        	}
		        	//Put the word in the map with a weight of 1
		        	else
		        		wordMap.put(s, 1);
		        }
		      }

		    } catch (Exception e) {
		      System.err.println(filename + " was not found!");
		    }
		
		//set size of the list and initialize the arrays
		size = wordMap.size();
		text = new String[size];
		weights = new int[size];
		
		
		//sort it!
		this.sortArrays();
		
	}
	
	/**
	 * Sort the arrays that contain the words and their associated weights
	 */
	public void sortArrays()
	{
		int counter = 0;
		//populate the arrays in an unsorted fashion
		for (Map.Entry<String, Integer> entry : wordMap.entrySet())
		{
			text[counter] = entry.getKey();
			weights[counter] = entry.getValue();
			counter++;
		}
		
		//Use a bubble sort
		for (int i = 1; i < size; i++)
		{
			boolean sorted = false;
			
			for (int j = 0; j < size - 1; j++)
			{
				if (weights[j+1] > weights[j])
				{
					int num = weights[j];
					String word = text[j];
					
					weights[j] = weights[j+1];
					text[j] = text[j+1];
					
					weights[j+1] = num;
					text[j+1] = word;
					
					sorted = false;
				}
			}
			
			if (sorted == true)
			{
				break;
			}
		}
		
		
		
	}
	
        public int getMax()
        {
          return weights[0];
        }
        
        public int getMin()
        {
          if (weights.length < 40)
            return weights[weights.length - 1];
          else
            return weights[39];
        }
	
	//Getters for the weights and their associated words
	public int[] getWeights()
	{
            if (weights.length < 40)
		return weights;
            else
                {
                  int tempweights[] = new int[40];
                  for (int i = 0; i < 40; i++)
                  {
                    tempweights[i] = weights[i];
                  }
                  return tempweights;
                }
	}
	
	public String[] getWords()
	{
            if (text.length < 40)
		return text;
            else
            {
                String temptext[] = new String[40];
                  for (int i = 0; i < 40; i++)
                  {
                    temptext[i] = text[i];
                  }
                  return temptext;
            }
	}
	
	/**
	 * Returns an array list containing all the words in the hash map.
	 * @return ArrayList
	 */
	public ArrayList<String> getAllWords()
	{
		ArrayList<String> words = new ArrayList<String>();
		
		//Add every item in the map to the array list
		for (Map.Entry<String, Integer> entry : wordMap.entrySet())
		{
			words.add(entry.getKey());
		}
		
		
		return words;
	}
	
	public void printKeysAndWeights()
	{
		for (Map.Entry<String, Integer> entry : wordMap.entrySet())
		{
			System.out.println("Key: " + entry.getKey() + " Value: " + entry.getValue());
		}
	}

}
