/**
 ******************************************************************************
 * @file           : main.c
 * @author         : NL
 * @brief          : Main program body, 
 * Application that blink the led of the nucleo board at a speed depending on the user button state
 ******************************************************************************
 */

/* 
 * Fichier d'include, qui inclus stm32f401xe.h se trouvant dans
 * Drivers/CMSIS/Device/ST/Include/
 * Ce fichier définit les types structure de donnée, les adresses de base,
 * les constantes, ...
 */

#include "stm32f4xx.h"
#define TRUE 1
#define FALSE 0

void wait(int n);

int main(void)
{
	int ms = 256;

	/*
	 * Déclaration de 2 instances de la structure GPIO qui sont mappées
	 * en mémoire à l'adresse du GPIOA pour PA et à l'adresse de GPIOC pour PC
	 * GPIOA est une constante définie dans le fichier stm32f401xe.h
	 */
	GPIO_TypeDef *PA = GPIOA, *PC = GPIOC;

	/*
	 * Mise à 1 des bits du registre RCC_AH1ENR de la puce
	 * permettant d'activer l'horloge des périphérique GPIOA et GPIOC
	 * il est à noter que cette fois ci, aucune variable n'est utilisée,
	 * la valeur numérique de l'adresse est directement fournie sous forme 
	 * d'une macro 
	 * RCC est défini en tant que macro dans stm32f401xe.h
	 * RCC_AHB1ENR_GPIOAEN, RCC_AHB1ENR_GPIOCEN sont des constantes définie dans
	 * stm32f401xe.h
	 */
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN | RCC_AHB1ENR_GPIOCEN;

	/*
	 * Configuration du GPIOA : mettre la pin PA5 en sortie, vitesse lente
	 * pour limiter les perturbations électroniques, sortie push-pull, sans 
	 * résistance de rappel. 
	 * note après un reset seule la mise de PA5 en sortie est nécessaire, les 
	 * autres configurations électriques étant celle souhaitées après un reset
	 */
	PA->MODER &= ~GPIO_MODER_MODER5_Msk; /* GPIO_MODER_MODER5_Msk : constante définie dans stm32f401xe.h */
	PA->MODER |= GPIO_MODER_MODER5_0;		 /* GPIO_MODER_MODER5_0, constante définie dans stm32f401xe.h */

	/* 
	 * Les autres paramètres sont déjà paramétrés comme il faut,
	 * Il n'est donc pas nécessaire de les reparamétrer
	 */

	/* boucle principale contenant le programme : boucle infinie. */
	while (TRUE)
	{
		// : On regarde si le bouton poussoire (PC13) est appuyé
		if ((PC->IDR & GPIO_IDR_ID13) == 0)
			ms = (ms + 256) % 1024; // si tel est le cas alors on augmente le temps entre chaque état

		PA->ODR &= ~GPIO_ODR_OD5; // on allume la diode (PC5)
		wait(ms);
		PA->ODR |= GPIO_ODR_OD5; // on éteint la diode (PC5)
		wait(ms);
	}
}

/**
 * @brief Petite fonction pour perdre du temps, et faire "patienter" le programme
 * @param ms temps en milisecondes
 */
void wait(int ms)
{
	for (; ms > 0; ms--)
	{
		for (int i = 0; i < 3195; i++)
		{
			// boucle vide
		}
	}
}
