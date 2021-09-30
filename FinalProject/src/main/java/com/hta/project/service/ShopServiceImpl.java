package com.hta.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.ShopDAO;
import com.hta.project.domain.Category;
import com.hta.project.domain.Product;

@Service
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopDAO dao = new ShopDAO();
	
	@Override
	public List<Category> getCategoryList() {
		return dao.getCategoryList();
	}


	@Override
	public int getProductListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		return dao.getProductListCount(map);
	}

	@Override
	public List<Product> getProductList(int index, String search_word, int page, int limit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getProductList(map);
	}

	@Override
	public Product getProductDetail(String code) {
		return dao.getProductDetail(code);
	}

	@Override
	public int getProductCategoryCount(String category_name) {
		String word = "%" + category_name + "%";
		return dao.getProductCategoryCount(word);
	}

	@Override
	public List<Product> getProductCategoryList(int page, int limit, String category_name) {
		List<Product> list = new ArrayList<Product>();
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		String word = "%" + category_name + "%";
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("word", word);
		
		list = dao.getProductCategoryList(map);
		
		return list;
	}

	
	
}
