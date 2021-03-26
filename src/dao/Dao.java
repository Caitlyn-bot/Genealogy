package dao;

import domain.Guquan;
import domain.PageBean;
import domain.TCorpEntity;
import domain.Touzi;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import utils.JDBCUtils;

import java.util.List;

public class Dao {
    JdbcTemplate template=new JdbcTemplate(JDBCUtils.getDataSource());
    //查询企业数量
    public int cor_num(String corname){
        String sql="select count(*) from t_corp where CORP_NAME like concat('%',?,'%')";
        return template.queryForObject(sql,Integer.class,corname);
    }
    //全部数量
    public int all_num(){
        String sql="select count(*) from t_corp ";
        return template.queryForObject(sql,Integer.class);
    }
    //查询全部
    public PageBean<TCorpEntity> queryAllByPage(String _currentPage, String _rows){
        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }

        //创建空的PageBean对象
        PageBean<TCorpEntity> pb = new PageBean<TCorpEntity>();

        Dao dao=new Dao();
        int totalCount =dao.all_num();
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        if (currentPage>=totalPage){
            currentPage=totalPage;
        }
        int start = (currentPage - 1) * rows;
        String sql="select * from t_corp  limit ?,?";
        List<TCorpEntity> list = template.query(sql, new BeanPropertyRowMapper<>(TCorpEntity.class), start, rows);
        //System.out.println(list);
        //设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);
        pb.setTotalCount(totalCount);
        pb.setTotalPage(totalPage);
        pb.setList(list);
        System.out.println("pb"+pb);
        return pb;
    }
    //按照分页
    public PageBean<TCorpEntity> queryByPage(String _currentPage, String _rows, String corname){
        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }

        //创建空的PageBean对象
        PageBean<TCorpEntity> pb = new PageBean<TCorpEntity>();

        Dao dao=new Dao();
        int totalCount =dao.cor_num(corname);
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        if (currentPage>=totalPage){
            currentPage=totalPage;
        }
        int start = (currentPage - 1) * rows;
        String sql="select * from t_corp where CORP_NAME like concat('%',?,'%') limit ?,?";
        List<TCorpEntity> list = template.query(sql, new BeanPropertyRowMapper<>(TCorpEntity.class),corname, start, rows);
        //System.out.println(list);
        //设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);
        pb.setTotalCount(totalCount);
        pb.setTotalPage(totalPage);
        pb.setList(list);
        System.out.println("pb"+pb);
        return pb;
    }
    //
    public TCorpEntity show(int id){
        String sql="select * from t_corp where XLFID=?";
        return template.queryForObject(sql,new BeanPropertyRowMapper<>(TCorpEntity.class),id);
    }
    public List<Guquan> show1(String corname){
        String sql="select * from guquan where corpname=?";
        return template.query(sql,new BeanPropertyRowMapper<>(Guquan.class),corname);
    }
    public List<Touzi> show2(String corname){
        String sql="select * from touzi where corpname=?";
        return template.query(sql,new BeanPropertyRowMapper<>(Touzi.class),corname);
    }
    public List<Guquan> show4(String corname){
        String sql="SELECT * from qiye where username in (SELECT username from qiye where corpname=?)";
        return template.query(sql,new BeanPropertyRowMapper<>(Guquan.class),corname);
    }

}
