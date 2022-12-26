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
