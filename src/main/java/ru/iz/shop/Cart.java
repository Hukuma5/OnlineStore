package ru.iz.shop;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Cart {
    HashMap<Item, Integer> itemHashMap = new HashMap<Item, Integer>();
    int totalPurchases = 0;

    public void addItem(Item item, int count){
        if (itemHashMap.containsKey(item)){
            itemHashMap.put(item, itemHashMap.get(item) + count);
        } else {
            itemHashMap.put(item, count);
        }
        this.totalPurchases += item.getPrice() * count;
    }

    public HashMap<Item, Integer> getCart(){
        return itemHashMap;
    }

    public int getTotalPurchases(){
        return this.totalPurchases;
    }

    public int getSize(){
        int count = 0;
        for (Item item: itemHashMap.keySet()){
            count += itemHashMap.get(item);
        }
        return count;
    }
}
