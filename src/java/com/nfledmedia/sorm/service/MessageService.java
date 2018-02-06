package com.nfledmedia.sorm.service;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nfledmedia.sorm.dao.MessageDAO;
import com.nfledmedia.sorm.entity.Message;
import com.nfledmedia.sorm.util.Page;

@Entity
@Transactional
@Service("messageService")
public class MessageService {

	@ManyToOne
	private MessageDAO messageDAO;

	public Page getMessageList(Integer user, String sidx, String sord,
			int pageNo, int pageSize) {
		return messageDAO.getMessageList(user, sidx, sord, pageNo, pageSize);
	}

	public void setMessagesRead(String ids) {
		String[] idss = ids.split(",");
		for (int i = 0, size = idss.length; i < size; i++) {
			setMessageRead(new Long(idss[i]));
		}
		setMessageRead(new Long(ids));
	}

	private void setMessageRead(Long id) {
		Message message = messageDAO.findById(id);
		System.out
				.println("MessageService中获取的mesaage的getId：" + message.getId());
		System.out.println("MessageService中获取的mesaage的hasRead修改前："
				+ message.getHasRead());
		if (message.getHasRead() != 1) {
			message.setHasRead(1);
			messageDAO.merge(message);
		}
		System.out.println("MessageService中获取的mesaage的hasRead修改后："
				+ message.getHasRead());
	}

	public long countNotReadMessage(Integer userId) {
		return this.messageDAO.countNotreadMessage(userId);
	}

	public void deleteMessage(String ids) {
		String[] idss = ids.split(",");
		for (int i = 0, size = idss.length; i < size; i++) {
			deleteMessage(new Long(idss[i]));
		}
	}

	public void deleteMessage(Long id) {
		Message message = messageDAO.findById(id);
		if (message.getHasRead() != 2) {
			message.setHasRead(2);
			messageDAO.merge(message);
		}
	}

	public MessageDAO getMessageDAO() {
		return messageDAO;
	}

	public void setMessageDAO(MessageDAO messageDAO) {
		this.messageDAO = messageDAO;
	}

	public void saveMessage(Message message) {
		messageDAO.save(message);		
	}

}
