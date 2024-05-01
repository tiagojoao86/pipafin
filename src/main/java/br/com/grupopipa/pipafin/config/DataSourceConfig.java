package br.com.grupopipa.pipafin.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

  @Value("${db.host}")
  private String dbHost;

  @Value("${db.database}")
  private String dbDatabase;

  @Value("${db.username}")
  private String dbUsername;

  @Value("${db.password}")
  private String dbPassword;

  @Value("${db.port}")
  private String dbPort;

  @Bean
  public DataSource buildDataSource() {
    return DataSourceBuilder.create() //
        .driverClassName("org.postgresql.Driver") //
        .url("jdbc:postgresql://" + dbHost + ":" + dbPort + "/" + dbDatabase) //
        .username(dbUsername) //
        .password(dbPassword) //
        .build();
  }

}
