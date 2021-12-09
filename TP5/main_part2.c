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

#define TRUE 1
#define FALSE 0

void ticking(int t);

GPIO_TypeDef *PA = GPIOA;
SysTick_Type *SYSTICK = SysTick;

int main(void)
{

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

  /*
	 * Configuration du GPIOA : mettre la pin PA5 en sortie, vitesse lente
	 * pour limiter les perturbations électroniques, sortie push-pull, sans 
	 * résistance de rappel. 
	 * note après un reset seule la mise de PA5 en sortie est nécessaire, les 
	 * autres configurations électriques étant celle souhaitées après un reset
	 */
  PA->MODER &= ~GPIO_MODER_MODER5_Msk; /* GPIO_MODER_MODER5_Msk : constante définie dans stm32f401xe.h */
  PA->MODER |= GPIO_MODER_MODER5_0;    /* GPIO_MODER_MODER5_0, constante définie dans stm32f401xe.h */

  /*
	 * Les autres paramètres sont déjà paramétrés comme il faut,
	 * Il n'est donc pas nécessaire de les reparamétrer
	 */

  SysTick_Config(16000); // toute les millisecondes

  while (TRUE)
  {
    PA->ODR ^= GPIO_ODR_OD5; // on inverse l'état de la led
    ticking(500);            // on attend 500ms
  }
}

void ticking(int ms)
{
  SYSTICK->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
  SYSTICK->LOAD = (ms - 1) * 16000;
  SYSTICK->VAL = 0;
  SYSTICK->CTRL |= SysTick_CTRL_ENABLE_Msk;

  while ((SYSTICK->CTRL & SysTick_CTRL_COUNTFLAG_Msk) != SysTick_CTRL_COUNTFLAG_Msk)
    ;
}
