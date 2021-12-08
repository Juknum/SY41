/**
 ******************************************************************************
 * @file           : main.c
 * @author         : NL
 * @brief          : Main program body,
 * 					 Application that blink the led of the nucleo board at
 * 					 a speed depending on the user button state
 ******************************************************************************
 */

/* fichier d'include, qui inclus stm32f401xe.h se trouvant dans
 * Drivers/CMSIS/Device/ST/Include/
 * Ce fichier définit les types structure de donnée, les adresses de base,
 * les constantes, ...
 */

#include "stm32f4xx.h"

int main(void)
{
	int i;
	/* déclaration de 2 instances de la structure GPIO qui sont mappées
	 * en mémoire à l'adresse du GPIOA pour PA et à l'adresse de GPIOC pour PC
	 * GPIOA est une constante définie dans le fichier stm32f401xe.h
	 */
	GPIO_TypeDef * PA = GPIOA, *PC = GPIOC;

	/* mise à 1 des bits du registre RCC_AH1ENR de la puce
	 * permettant d'activer l'horloge des périphérique GPIOA et GPIOC
	 * il est à noter que cette fois ci, aucune variable n'est utilisée,
	 * la valeur numérique de l'adresse est directement fournie sous forme 
	 * d'une macro 
	 * RCC est défini en tant que macro dans stm32f401xe.h
	 * RCC_AHB1ENR_GPIOAEN, RCC_AHB1ENR_GPIOCEN sont des constantes définie dans
	 * stm32f401xe.h
	 */
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN | RCC_AHB1ENR_GPIOCEN;

	/* configuration du GPIOA : mettre la pin PA5 en sortie, vitesse lente
	 * pour limiter les perturbations électroniques, sortie push-pull, sans 
	 * résistance de rappel. 
	 * note après un reset seule la mise de PA5 en sortie est nécessaire, les 
	 * autres configurations électriques étant celle souhaitées après un reset
	 */
	PA->MODER &= ~GPIO_MODER_MODER5_Msk; /* GPIO_MODER_MODER5_Msk : constante 
											définie dans stm32f401xe.h */
	PA->MODER |= GPIO_MODER_MODER5_0;	/* GPIO_MODER_MODER5_0, constante 
											définie dans stm32f401xe.h */

	/* ... */


	/* boucle principale contenant le programme : boucle infinie. */
	for(;;){

	}
}
