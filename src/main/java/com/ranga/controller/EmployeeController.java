package com.ranga.controller;

import com.ranga.entity.Employee;
import com.ranga.service.EmployeeService;

import org.jboss.logging.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.beans.support.PagedListHolder;



@Controller
public class EmployeeController {
	
	private static final Logger logger = Logger.getLogger(EmployeeController.class);
	
	public EmployeeController() {
		System.out.println("EmployeeController()");
	}

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("createEmployee")
    public ModelAndView createEmployee(@ModelAttribute Employee employee) {
    	logger.info("Creating Employee. Data: "+employee);
        return new ModelAndView("employeeForm");
    }
    
    @RequestMapping("editEmployee")
    public ModelAndView editEmployee(@RequestParam long id, @ModelAttribute Employee employee) {
    	logger.info("Updating the Employee for the Id "+id);
        employee = employeeService.getEmployee(id);
        return new ModelAndView("employeeForm", "employeeObject", employee);
    }
    
    @RequestMapping("saveEmployee")
    public ModelAndView saveEmployee(@ModelAttribute Employee employee) {
    	logger.info("Saving the Employee. Data : "+employee);
        if(employee.getId() == 0){ // if employee id is 0 then creating the employee other updating the employee
            employeeService.createEmployee(employee);
        } else {
            employeeService.updateEmployee(employee);
        }
        return new ModelAndView("redirect:getAllEmployees");
    }
    
    @RequestMapping("deleteEmployee")
    public ModelAndView deleteEmployee(@RequestParam long id) {
    	logger.info("Deleting the Employee. Id : "+id);
        employeeService.deleteEmployee(id);
        return new ModelAndView("redirect:getAllEmployees");
    }
    
    @RequestMapping(value = {"getAllEmployees", "/"})
    public ModelAndView getAllEmployees(@RequestParam(required = false) Integer page) {
    	logger.info("Getting the all Employees.");
        //List<Employee> employeeList = employeeService.getAllEmployees();
     //   PagedListHolder<Employee> pagedListHolder = new PagedListHolder(employeeService.getAllEmployees());
        //pagedListHolder.setPage(10);
       // pagedListHolder.setPageSize(5);

        //String page = request.getParameter("page");

        //if ("prev".equals(page))
        //{
          //  pagedListHolder.previousPage();
        //}
        //if ("next".equals(page))
        //{
          //  pagedListHolder.nextPage();
        //}

        //return new ModelAndView("employeeList", "allEmployees", pagedListHolder.getPageList());
        ModelAndView modelAndView = new ModelAndView("employeeList");

        PagedListHolder<Employee> pagedListHolder = new PagedListHolder(employeeService.getAllEmployees());
        pagedListHolder.setPageSize(5);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if(page==null || page < 1 || page > pagedListHolder.getPageCount())page=1;
        modelAndView.addObject("page", page);

        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            modelAndView.addObject("allEmployees", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            modelAndView.addObject("allEmployees", pagedListHolder.getPageList());
        }

        return  modelAndView;
    }
    
    @RequestMapping("searchEmployee")
    public ModelAndView searchEmployee(@RequestParam("searchName") String searchName,Integer page) {
    	logger.info("Searching the Employee. Employee Names: "+searchName);
        ModelAndView modelAndView = new ModelAndView("employeeListSearch");


            PagedListHolder<Employee> pagedListHolderSearch = new PagedListHolder(employeeService.getAllEmployees(searchName));
            pagedListHolderSearch.setPageSize(5);
            modelAndView.addObject("maxPages", pagedListHolderSearch.getPageCount());


        if(page==null || page < 1 || page > pagedListHolderSearch.getPageCount())page=1;
        modelAndView.addObject("page", page);

        if(page == null || page < 1 || page > pagedListHolderSearch.getPageCount()){
            pagedListHolderSearch.setPage(0);
            modelAndView.addObject("allEmployeesSearch", pagedListHolderSearch.getPageList());
        }
        else if(page <= pagedListHolderSearch.getPageCount()) {
            pagedListHolderSearch.setPage(page-1);
            modelAndView.addObject("allEmployeesSearch", pagedListHolderSearch.getPageList());
        }

        return modelAndView;
    }
}