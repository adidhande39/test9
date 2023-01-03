@Component
public class RequestIdFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String requestId = UUID.randomUUID().toString();
        response.addHeader("X-Request-Id", requestId);
        filterChain.doFilter(request, response);
    }
}

@Service
public class MyService {

    private final RestTemplate restTemplate;

    public MyService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    public String getData() {
        return restTemplate.getForObject("http://localhost:8000/api/data", String.class);
    }
}
@Service
public class MyService {

    private final RestTemplate restTemplate;

    public MyService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }
    
    
    
SELECT c.name AS COLUMN_NAME, t.name AS TYPE_NAME, c.is_nullable AS NULLABLE
FROM sys.columns c
JOIN sys.types t ON c.system_type_id = t.system_type_id
WHERE c.object_id = OBJECT_ID('company.dbo.employees')
    
    import java.lang.reflect.Type;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class ResponseIdAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
            ServerHttpResponse response) {
        if (request instanceof ServletServerHttpRequest) {
            HttpServletRequest httpRequest = ((ServletServerHttpRequest) request).getServletRequest();
            UUID responseId = (UUID) httpRequest.getAttribute("responseId");
            // Add the response ID to the response body
            ResponseObject responseObject = new ResponseObject();
            responseObject.setResponseId(responseId.toString());
            responseObject.setData(body);
            return responseObject;
        }
        return body;
    }
}

    
    import java.lang.reflect.Type;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class ResponseIdAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
            ServerHttpResponse response) {
        if (request instanceof ServletServerHttpRequest) {
            HttpServletRequest httpRequest = ((ServletServerHttpRequest) request).getServletRequest();
            UUID responseId = (UUID) httpRequest.getAttribute("responseId");
            // Add the response ID to the response body
            ResponseObject responseObject = new ResponseObject();
            responseObject.setResponseId(responseId.toString());
            responseObject.setData(body);
            return responseObject;
        }
        return body;
    }
}


    public ResponseEntity<String> getData() {
        return restTemplate.getForEntity("http://localhost:8000/api/data", String.class);
    }
}
ResponseEntity<String> response = myService.getData();

int statusCode = response.getStatusCode().value();
HttpHeaders headers = response.getHeaders();
String body = response.getBody();

@Component
public class UuidLoggingFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(UuidLoggingFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String uuid = request.getHeader("X-Request-Id");
        logger.info("Received request with UUID: {}", uuid);
        filterChain.doFilter(request, response);
    }
}

@Bean
public FilterRegistrationBean<UuidLoggingFilter> uuidLoggingFilter() {
    FilterRegistrationBean<UuidLoggingFilter> registrationBean = new FilterRegistrationBean<>();
    registrationBean.setFilter(new UuidLoggingFilter());
    registrationBean.addUrlPatterns("/*");
    return registrationBean;
}


import java.io.IOException;
import java.util.UUID;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

@Component
public class RequestIdFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        UUID requestId = UUID.randomUUID();
        httpRequest.setAttribute("requestId", requestId);
        chain.doFilter(request, response);
    }
}


@RestController
public class MyController {

    @RequestMapping("/endpoint")
    public String handleRequest(HttpServletRequest request) {
        UUID requestId = (UUID) request.getAttribute("requestId");
        // Use the request ID as needed
        ...
    }
}

@Service
public class MyService {

    private final RestTemplate restTemplate;

    public MyService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    public String getData(String headerValue) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Custom-Header", headerValue);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange("http://localhost:8000/api/data", HttpMethod.GET, entity, String.class);
        return response.getBody();
    }
}

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class RequestIdFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestId = httpRequest.getHeader("Request-Id");
        if (requestId != null) {
            httpResponse.setHeader("Request-Id", requestId);
        }

        chain.doFilter(request, response);
    }
}


import java.lang.reflect.Type;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class ResponseIdAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
            ServerHttpResponse response) {
        UUID responseId = (UUID) request.getAttribute("responseId");
        // Add the response ID to the response body
        if (body instanceof Map) {
            Map<String, Object> map = (Map<String, Object>) body;
            map.put("responseId", responseId.toString());
            return map;
        }
        return body;
    }
}


import java.lang.reflect.Type;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class ResponseIdAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
            ServerHttpResponse response) {
        UUID responseId = (UUID) request.getAttribute("responseId");
        // Add the response ID to the response body
        ResponseObject responseObject = new ResponseObject();
        responseObject.setResponseId(responseId.toString());
        responseObject.setData(body);
        return responseObject;
    }
}


public class ResponseObject {
    private String responseId;
    private Object data;

    public String getResponseId() {
        return responseId;
    }

    public void setResponseId(String responseId) {
        this.responseId = responseId;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}


@ControllerAdvice
public class ResponseIdAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
            Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
            ServerHttpResponse response) {
        HttpServletRequest httpRequest = (HttpServletRequest) request.getNativeRequest();
        UUID responseId = (UUID) httpRequest.getAttribute("responseId");
        // Add the response ID to the response body
        ResponseObject responseObject = new ResponseObject();
        responseObject.setResponseId(responseId.toString());
        responseObject.setData(body);
        return responseObject;
    }
}

