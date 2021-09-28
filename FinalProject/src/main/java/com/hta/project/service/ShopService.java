package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Category;
import com.hta.project.domain.Product;

public interface ShopService {

	List<Category> getCategoryList();

	Product getProductDetail(String code);

	List<Product> getProductList(int page, int limit);

	int getProductListCount();

}
