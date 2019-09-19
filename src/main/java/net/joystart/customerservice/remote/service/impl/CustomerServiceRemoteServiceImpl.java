package net.joystart.customerservice.remote.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.customerservice.dao.AnswerQuestionMapper;
import net.joystart.customerservice.dao.QuestionCategoryMapper;
import net.joystart.customerservice.dao.ServiceEventMapper;
import net.joystart.customerservice.entity.AnswerQuestion;
import net.joystart.customerservice.entity.QuestionCategory;
import net.joystart.customerservice.entity.ServiceEvent;
import net.joystart.customerservice.remote.service.ICustomerServiceRemoteService;
import net.joystart.illegal.remote.service.IViolationQueryRemoteService;

@Service(timeout=60000,retries=0)
public class CustomerServiceRemoteServiceImpl implements ICustomerServiceRemoteService {
	
	@Resource
	private ServiceEventMapper serviceEventMapper;
	@Resource
	private AnswerQuestionMapper answerQuestionMapper;
	@Resource
	private QuestionCategoryMapper questionCategoryMapper;
	
	@Resource
    IViolationQueryRemoteService violationQueryRemoteService;
	
	@Override
	public int insertSelective(ServiceEvent record) {
		return serviceEventMapper.insertSelective(record);
	}

	@Override
	public int modifyFaultRecordById(ServiceEvent record) {
		return serviceEventMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public ServiceEvent getServiceEventById(Integer eventId) {
		return serviceEventMapper.selectByPrimaryKey(eventId);
	}

	@Override
	public List<ServiceEvent> getServiceEvents(Map<String, Object> params) {
		return serviceEventMapper.getServiceEvents(params);
	}

	@Override
	public int getServiceEventCount(Map<String, Object> params) {
		return serviceEventMapper.getServiceEventCount(params);
	}

	@Override
	public int deleteServiceEvent(String[] ids) {
		return serviceEventMapper.deleteServiceEvent(ids);
	}

	@Override
	public List<AnswerQuestion> getAnswerQuestions(Map<String, Object> params) {
		return answerQuestionMapper.getAnswerQuestions(params);
	}

	@Override
	public int getAnswerQuestionCount(Map<String, Object> params) {
		return answerQuestionMapper.getAnswerQuestionCount(params);
	}

	@Override
	public int insertQuestion(AnswerQuestion record) {
		return answerQuestionMapper.insertSelective(record);
	}

	@Override
	public int modifyQuestionById(AnswerQuestion record) {
		return answerQuestionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public AnswerQuestion getQuestionById(Integer questionId) {
		return answerQuestionMapper.selectByPrimaryKey(questionId);
	}

	@Override
	public List<QuestionCategory> getAllQuestionCategories() {
		return questionCategoryMapper.getAllQuestionCategories();
	}

    @Override
    public int getViolationCount(Map<String, Object> params) {
        return violationQueryRemoteService.getViolationCount(params);
    }
	
}
