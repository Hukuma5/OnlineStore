package ru.iz.shop;

public class Item {
    private final String name;
    private final String articleNumber;
    private final double price;

    public Item(String name, String articleNumber, double price){
        this.name = name;
        this.articleNumber = articleNumber;
        this.price = price;
    }

    public String getName() {
        return this.name;
    }

    public String getArticleNumber(){
        return this.articleNumber;
    }

    public double getPrice(){
        return this.price;
    }
}
