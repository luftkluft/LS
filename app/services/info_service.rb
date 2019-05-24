class InfoService
  APP_VERSION = 'Version: 0.0.1'.freeze
  require 'socket'

  def app_info(current_user)
    return I18n.t('app_info.current_user_error') unless current_user

    common_info = common_info('', current_user)
    if current_user.role == 'admin'
      admin_info(common_info)
    else
      common_info
    end
  rescue StandardError
    I18n.t('app_info.app_info_error')
  end

  private

  def common_info(info, current_user)
    info += I18n.t('app_info.version', version: APP_VERSION) + '\n'
    info += I18n.t('app_info.current_user') + current_user.email + '\n'
    info + I18n.t('app_info.role') + current_user.role + '\n'
  end

  def admin_info(common_info)
    database_info(common_info, Rails.configuration.database_configuration[Rails.env])
  rescue StandardError
    common_info + I18n.t('app_info.admin_info_error')
  end

  def database_info(info, db_info)
    info = net_info(info)
    info += 'Database info:' + '\n'
    info = main_database_info(info, db_info)
    info = size_database_info(info, db_info)
    tablesrowcount(info) # <= for full info
  end

  def size_database_info(info, db_info)
    info + '-total size: ' + database_memory_size(db_info['database']) + '\n'
  rescue StandardError
    info + I18n.t('app_info.size_database_info_error') + '\n'
  end

  def main_database_info(info, db_info)
    info += '-adapter: ' + db_info['adapter'] + '\n'
    info += '-name: ' + db_info['database'] + '\n'
    info += '-encoding: ' + db_info['encoding'] + '\n'
    info += '-username: ' + db_info['username'] + '\n'
    info + '-password: ' + db_info['password'] + '\n'
  rescue StandardError
    info + I18n.t('app_info.main_database_info_error') + '\n'
  end

  def net_info(info)
    info += 'PC name: ' + Socket.gethostname + '\n'
    info + 'NetIP: ' + Socket.ip_address_list.detect(&:ipv4_private?)&.ip_address + '\n'
  rescue StandardError
    info + I18n.t('app_info.net_error') + '\n'
  end

  def database_memory_size(db_name)
    results = ActiveRecord::Base.connection.exec_query(
      "SELECT pg_size_pretty(pg_database_size('#{db_name}'));"
    )
    results.first['pg_size_pretty']
  rescue StandardError
    I18n.t('app_info.database_memory_size_error')
  end

  def totalrowcount
    results = ActiveRecord::Base.connection.exec_query(
      "SELECT
      SUM(pgClass.reltuples) AS totalRowCount
      FROM
      pg_class pgClass
      LEFT JOIN
      pg_namespace pgNamespace ON (pgNamespace.oid = pgClass.relnamespace)
      WHERE
      pgNamespace.nspname NOT IN ('pg_catalog', 'information_schema') AND
      pgClass.relkind='r'"
    )
    results.first['totalrowcount'].to_s
  rescue StandardError
    I18n.t('app_info.totalrowcount_error')
  end

  def tablesrowcount(info)
    info += '-total rows: ' + totalrowcount + '\n'
    results = ActiveRecord::Base.connection.exec_query(
      "SELECT
      pgClass.relname AS tableName,
      pgClass.reltuples AS rowCount
      FROM
      pg_class pgClass
      LEFT JOIN
      pg_namespace pgNamespace ON (pgNamespace.oid = pgClass.relnamespace)
      WHERE
      pgNamespace.nspname NOT IN ('pg_catalog', 'information_schema') AND
      pgClass.relkind='r'"
    )
    results.each do |row|
      info += '  =' + row['tablename'] + ': '
      info += row['rowcount'].to_s + '\n'
    end
    info
  end
end
