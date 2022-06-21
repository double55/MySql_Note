# Group By

在Group By查询语句中，select的字段只能是Group By中的字段和聚合函数（max(a)）。

## Group_Concat

***实例***

[牛客——SQL12 获取每个部门中当前员工薪水最高的相关信息](https://www.nowcoder.com/practice/4a052e3e1df5435880d4353eb18a91c6?tpId=82&tqId=29764&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fdifficulty%3D5%26judgeStatus%3D1%26page%3D1%26pageSize%3D50%26search%3D%26tab%3DSQL%25E7%25AF%2587%26topicId%3D82&difficulty=5&judgeStatus=1&tags=&title=)

```mysql
SELECT dept_no,
       SUBSTRING_INDEX(GROUP_CONCAT(dept_emp.emp_no ORDER BY salary DESC), ',', 1) AS emp_no,
       MAX(salary)                                                                 AS maxSalary
FROM dept_emp,
     salaries
WHERE dept_emp.emp_no = salaries.emp_no
GROUP BY dept_no ASC;
```