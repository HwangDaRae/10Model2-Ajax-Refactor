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

	/*
	@RequestMapping(value = "listProduct/{menu}") 
	public String listProduct( @PathVariable String menu, Model model, HttpSession session, Search search) throws Exception {
		System.out.println("/product/listProduct : GET");
		System.out.println(search);
		System.out.println(menu);
		System.out.println(session.getAttribute("user"));
		
		if(((User)session.getAttribute("user")).getUserId().equals("non-member")) {
			//��ȸ�� ��ǰ �˻� Anchor Tag Ŭ��
			System.out.println("��ȸ������ ���Դ�");
		}else if(((User)session.getAttribute("user")).getRole().equals("admin")) {
			System.out.println("admin�������� ���Դ�");
		}else {
			System.out.println("user�������� ���Դ�");
		}

		// ��ǰ�˻� Ŭ�������� currentPage�� null�̴�
		int currentPage = 1;

		// ��ǰ�˻� Ŭ���� null, �˻���ư Ŭ���� nullString
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}

		// �ǸŻ�ǰ���� Ŭ���� searchKeyword, searchCondition �� �� null ==> nullString ���� ��ȯ
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		// ��ǰ��� ��ǰ���ݿ��� searchKeyword�� �����϶� nullString���� ��ȯ
		if (!searchCondition.trim().equals("1") && !CommonUtil.parsingCheck(searchKeyword)) {
			searchKeyword = "";
		}
		search = new Search(currentPage, searchCondition, searchKeyword, pageSize, search.getPriceSort());
		
		// �˻������� �־ ���� �������� list�� �����´�
		List<Product> prodList = productServiceImpl.getProductList(search);		
		int totalCount = productServiceImpl.getProductTotalCount(search);		
		Page resultPage = new Page(currentPage, totalCount, pageUnit, pageSize);
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searchVO", search);
		model.addAttribute("list", prodList);
		model.addAttribute("listSize", prodList.size());
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	*/

	/*
	@RequestMapping( value = "listProduct", method = RequestMethod.POST )
	public String listProduct( @RequestParam("menu") String menu, Model model, User user, HttpSession session, Search search) throws Exception {
		System.out.println("/product/listProduct : POST");
		
		System.out.println(search);
		System.out.println(user);
		System.out.println(menu);
		System.out.println(session.getAttribute("user"));
		
		
		if(((User)session.getAttribute("user")).getUserId().equals("non-member")) {
			//��ȸ�� ��ǰ �˻� Anchor Tag Ŭ��
			System.out.println("��ȸ������ ���Դ�");
		}else if(((User)session.getAttribute("user")).getRole().equals("admin")) {
			System.out.println("admin�������� ���Դ�");
		}else {
			System.out.println("user�������� ���Դ�");
		}

		// ��ǰ�˻� Ŭ�������� currentPage�� null�̴�
		int currentPage = 1;

		// ��ǰ�˻� Ŭ���� null, �˻���ư Ŭ���� nullString
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}

		// �ǸŻ�ǰ���� Ŭ���� searchKeyword, searchCondition �� �� null ==> nullString ���� ��ȯ
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		// ��ǰ��� ��ǰ���ݿ��� searchKeyword�� �����϶� nullString���� ��ȯ
		if (!searchCondition.trim().equals("1") && !CommonUtil.parsingCheck(searchKeyword)) {
			searchKeyword = "";
		}
		search = new Search(currentPage, searchCondition, searchKeyword, pageSize, search.getPriceSort());
		
		// �˻������� �־ ���� �������� list�� �����´�
		List<Product> prodList = productServiceImpl.getProductList(search);		
		int totalCount = productServiceImpl.getProductTotalCount(search);		
		Page resultPage = new Page(currentPage, totalCount, pageUnit, pageSize);
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searchVO", search);
		model.addAttribute("list", prodList);
		model.addAttribute("listSize", prodList.size());
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	*/

}


