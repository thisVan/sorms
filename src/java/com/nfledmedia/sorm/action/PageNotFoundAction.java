package com.nfledmedia.sorm.action;

import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 处理404
 */
@Controller
public class PageNotFoundAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Override
	public String execute() throws Exception {
		return "404";
	}
}
