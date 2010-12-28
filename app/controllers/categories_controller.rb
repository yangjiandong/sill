class CategoriesController < ApplicationController
  skip_before_filter :check_authentication

  def index

  end

  def index_json
    @datas = Category.find(:all)
    debug_log("category,datas:" + @datas.to_json)

    render :json => {
        :rows => @datas,
        :results => @datas.count
        }, :layout => false
  end

  def category_tree
    # Rails.logger.info("Begin ... tree")
    categories = Category.find_by_sql("select * from t_categories where parent_id is null")
    data = get_tree(categories, nil)
    render :text => data.to_json, :layout => false
  end

  def layout

  end

  def get_tree(categories, parent)
    data = Array.new

    categories.each { |category|
      if !category.leaf?
        if data.empty?
          Rails.logger.info("icon-docs, tree" + category.description)
          data = [{"text" => category.description,
          "id" => category.id,
          #"iconCls" => "icon-docs", #"icon-docs",
          "cls" => "fold",
          "leaf" => false,
          "singleClickExpand" => true,
          "children" => get_tree(category.children, category)
          }]
        else
          Rails.logger.info("icon-pkg, tree" + category.description)
          data.concat([{"text" => category.description,
                      "id" => category.id,
                      #"iconCls" => "icon-pkg",
                      "cls" => "fold",#"package",
                      "leaf" => false,
                      "singleClickExpand" => true,
                      "children" => get_tree(category.children, category)}])
        end

      else

        data.concat([{"text" => category.description,
                    "href" => "output/Ext.chart.BarChart.html",
                    "id" => category.id,
                    "iconCls" => "icon-cls",
                    "cls" => "cls",#"file",
                    "isClass" => true,
                    "leaf" => true}])

      end
    }
    return data
  end
end
