package br.com.grupopipa.financeiro.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import jakarta.persistence.EntityManagerFactory;

import javax.sql.DataSource;

@Configuration
@EnableJpaRepositories(basePackages = "br.com.grupopipa.financeiro.repository")
@EnableTransactionManagement
public class DataSourceConfig {

    public static final String POSTGRES_DRIVER = "org.postgresql.Driver";

    private static final String ENTITY_PACKAGE = "br.com.grupopipa.financeiro.entity";

    @Value("${datasource.url}")
    private String dbUrl;

    @Value("${datasource.username}")
    private String dbUsername;
    
    @Value("${datasource.password}")
    private String dbPassword;

    @Bean
    public DataSource dataSource() {
        return DataSourceBuilder.create()
                                .driverClassName(POSTGRES_DRIVER)
                                .url(dbUrl)
                                .username(dbUsername)
                                .password(dbPassword)
                                .build();
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {

        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        vendorAdapter.setGenerateDdl(true);

        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
        factory.setJpaVendorAdapter(vendorAdapter);
        factory.setPackagesToScan(ENTITY_PACKAGE);
        factory.setDataSource(dataSource());
        return factory;
    }

    @Bean
    public PlatformTransactionManager transactionManager(EntityManagerFactory entityManagerFactory) {

        JpaTransactionManager txManager = new JpaTransactionManager();
        txManager.setEntityManagerFactory(entityManagerFactory);
        return txManager;
    }

}