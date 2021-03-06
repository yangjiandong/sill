class CategoriesController < ApplicationController
  skip_before_filter :check_authentication

  def index

  end

  def index_json
    @datas = Category.find(:all)
    #debug_log("category,datas:" + @datas.to_json)

    render :json => {
        :rows => @datas,
        :results => @datas.count
        }, :layout => false
  end

  def category_tree
    # Rails.logger.info("Begin ... tree")
    categories = Category.find_by_sql("select * from t_categories where parent_id is null")
    data = get_tree(categories, nil)

    #Rails.logger.info("data tree:" + data.to_json)
    render :text => data.to_json, :layout => false
  end

  def layout

  end

  def get_tree(categories, parent)
    data = Array.new

    # 一般以iconCls为树节点显示图标
    categories.each { |category|
      if !category.leaf?
        if data.empty?
          Rails.logger.info("icon-docs, tree" + category.description)
          data = [{"text" => category.description,
          "id" => 'ext.' + category.id.to_s,
          #"iconCls" => "icon-pkg", #"icon-docs",
          "cls" => "fold",
          "leaf" => false,
          "singleClickExpand" => true,
          "children" => get_tree(category.children, category)
          }]
        else
          Rails.logger.info("icon-pkg, tree" + category.description)
          data.concat([{"text" => category.description,
                      "id" => 'ext.'+ category.id.to_s,
                      #"iconCls" => "icon-pkg",
                      "cls" => "fold",#"package",
                      "leaf" => false,
                      "singleClickExpand" => true,
                      "children" => get_tree(category.children, category)}])
        end

      else

        data.concat([{"text" => category.description,
                    "href" => "output/Ext.chart.BarChart.html",
                    "id" => 'ext.'+ category.id.to_s,
                    "iconCls" => "user_commentIcon",
                    #"cls" => "cls",#"file",
                    "isClass" => true,
                    "leaf" => true}])

      end
    }
    return data
  end
end
