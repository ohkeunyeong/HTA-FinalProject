package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Category;
import com.hta.project.domain.Product;

public interface ShopService {

	public List<Category> getCategoryList();

	public int getProductListCount(int index, String search_word);

	public Product getProductDetail(String code);
	
	public int getProductCategoryCount(String category_name);

	public List<Product> getProductCategoryList(int page, int limit, String category_name);
	
	public List<Product> getProductList(int index, String search_word, int page, int limit);

	public List<Product> getPersonaconList(int index, String search_word, int page, int limit );

	public List<Product> getToolsList(int index, String search_word, int page, int limit );

	public List<Product> getGoodsList(int index, String search_word, int page, int limit );

	public List<Product> getReviewProductList(int index, String search_word, int page, int limit);
	
	public List<Product> getReviewList(int index, String search_word, int page, int limit );

	

}
