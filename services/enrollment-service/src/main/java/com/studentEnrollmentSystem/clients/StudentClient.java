package com.studentEnrollmentSystem.clients;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.core.publisher.Mono;

@Component
public class StudentClient {
	private final WebClient webClient;
	public StudentClient(WebClient.Builder webClientBuilder, @Value("${student-service.url:http://student-service}") String baseUrl) {
		this.webClient = webClientBuilder.baseUrl(baseUrl).build();
	}
	public Mono<Map> getStudentById(Long id) {
        return webClient.get().uri("/students/{id}", id).retrieve().bodyToMono(Map.class);
    }

    public Mono<Map> getStudentByCnie(String cnie) {
        return webClient.get().uri("/students/cnie/{cnie}", cnie).retrieve().bodyToMono(Map.class);
    }
}
