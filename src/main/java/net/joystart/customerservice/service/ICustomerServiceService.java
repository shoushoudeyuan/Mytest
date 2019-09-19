package net.joystart.customerservice.service;

import java.util.List;
import java.util.Map;

import net.joystart.customerservice.entity.AnswerQuestion;
import net.joystart.customerservice.entity.QuestionCategory;
import net.joystart.customerservice.entity.ServiceEvent;

/**
 * 客服管理接口
 * @author LDY20151214
 * 注:单词重复,是故意为之,不是BUG
 */
public interface ICustomerServiceService {

	int insertSelective(ServiceEvent record);
	
	int modifyFaultRecordById(ServiceEvent record);

	ServiceEvent getServiceEventById(Integer eventId);

	List<ServiceEvent> getServiceEvents(Map<String, Object> params);

	int getServiceEventCount(Map<String, Object> params);

	int deleteServiceEvent(String[] ids);

	List<AnswerQuestion> getAnswerQuestions(Map<String, Object> params);

	int getAnswerQuestionCount(Map<String, Object> params);

	int insertQuestion(AnswerQuestion record);

	int modifyQuestionById(AnswerQuestion record);

	AnswerQuestion getQuestionById(Integer questionId);

	List<QuestionCategory> getAllQuestionCategories();

	int getViolationCount(Map<String, Object> params);

}
