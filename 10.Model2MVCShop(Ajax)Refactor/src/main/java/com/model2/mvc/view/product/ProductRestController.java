package com.model2.mvc.view.product;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.upload.UploadService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	UploadService uploadServiceImpl;

	public ProductRestController() {
		System.out.println(getClass() + " default Constructor()]");
		System.out.println("pageSize : " + pageSize);
		System.out.println("pageUnit : " + pageUnit);
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value = "getProduct/{prodNo}/{menu}", method = RequestMethod.GET )
	public Map<String, Object> getProduct(@PathVariable int prodNo, @PathVariable String menu) throws Exception {
		System.out.println("/getProduct : GET");
		List<Upload> uploadList = uploadServiceImpl.getUploadFile(productServiceImpl.getProduct(prodNo).getFileName());		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productVO", productServiceImpl.getProduct(prodNo));
		map.put("uploadList", uploadServiceImpl.getUploadFile(productServiceImpl.getProduct(prodNo).getFileName()));
		map.put("count", uploadList.get(0).getFileCount());
		return map;
	}
	
	@RequestMapping( value = "autocompleteProduct", method = RequestMethod.POST )
	public List<String> autocompleteProduct() throws Exception {
		System.out.println("/autocompleteProduct : POST");
		return productServiceImpl.autocompleteProduct();
	}
	
	@RequestMapping( value = "/json/listProduct", method = RequestMethod.POST )
	public List<Map<String, Object>> listProduct( @RequestBody String menu, User user, Search search) throws Exception {
		System.out.println("/product/listProduct : POST");
		System.out.println(search);
		System.out.println(user);
		System.out.println(menu);

		// 상품검색 클릭했을때 currentPage는 null이다
		int currentPage = 1;

		// 상품검색 클릭시 null, 검색버튼 클릭시 nullString
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}

		// 판매상품관리 클릭시 searchKeyword, searchCondition 둘 다 null ==> nullString 으로 변환
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		// 상품명과 상품가격에서 searchKeyword가 문자일때 nullString으로 변환
		if (!searchCondition.trim().equals("1") && !CommonUtil.parsingCheck(searchKeyword)) {
			searchKeyword = "";
		}
		search = new Search(currentPage, searchCondition, searchKeyword, pageSize, search.getPriceSort());
		
		// 검색정보를 넣어서 현재 페이지의 list를 가져온다
		List<Product> prodList = productServiceImpl.getProductList(search);		
		int totalCount = productServiceImpl.getProductTotalCount(search);		
		Page resultPage = new Page(currentPage, totalCount, pageUnit, pageSize);
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		List<String> uploadList = new ArrayList<String>();
		for (int i = 0; i < prodList.size(); i++) {
			prodList.get(i).setFileName(uploadServiceImpl.getUploadFile(prodList.get(i).getFileName()).get(0).getFileName());
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultPage", resultPage);
		map.put("searchVO", search);
		map.put("list", prodList);
		map.put("menu", menu);
		List resultValue = new ArrayList();
		resultValue.add(resultPage);
		resultValue.add(search);
		resultValue.add(prodList);
		resultValue.add(resultPage);
		
		for (int i = 0; i < resultValue.size(); i++) {
			System.out.println(resultValue.get(i));
		}
		
		return resultValue;
	}

}


