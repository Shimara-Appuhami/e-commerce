<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/24/2025
  Time: 6:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop by Category</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="shortcut icon" href="https://raw.githubusercontent.com/bedimcode/responsive-plants-website/main/assets/img/favicon.png" type="image/x-icon">

    <!--=============== REMIX ICONS ===============-->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>

             /*=============== GOOGLE FONTS ===============*/
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap");

        /*=============== VARIABLES CSS ===============*/
        :root {
            --header-height: 3.5rem; /*56px*/

            /*========== Colors ==========*/
            /*Color mode HSL(hue, saturation, lightness)*/
            --hue: 152;
            --first-color: hsl(var(--hue), 24%, 32%);
            --first-color-alt: hsl(var(--hue), 24%, 28%);
            --first-color-light: hsl(var(--hue), 24%, 66%);
            --first-color-lighten: hsl(var(--hue), 24%, 92%);
            --title-color: hsl(var(--hue), 4%, 15%);
            --text-color: hsl(var(--hue), 4%, 35%);
            --text-color-light: hsl(var(--hue), 4%, 55%);
            --body-color: hsl(var(--hue), 0%, 100%);
            --container-color: #fff;

            /*========== Font and typography ==========*/
            /*.5rem = 8px | 1rem = 16px ...*/
            --body-font: "Poppins", sans-serif;
            --big-font-size: 2rem;
            --h1-font-size: 1.5rem;
            --h2-font-size: 1.25rem;
            --h3-font-size: 1rem;
            --normal-font-size: 0.938rem;
            --small-font-size: 0.813rem;
            --smaller-font-size: 0.75rem;

            /*========== Font weight ==========*/
            --font-medium: 500;
            --font-semi-bold: 600;

            /*========== Margenes Bottom ==========*/
            /*.5rem = 8px | 1rem = 16px ...*/
            --mb-0-5: 0.5rem;
            --mb-0-75: 0.75rem;
            --mb-1: 1rem;
            --mb-1-5: 1.5rem;
            --mb-2: 2rem;
            --mb-2-5: 2.5rem;

            /*========== z index ==========*/
            --z-tooltip: 10;
            --z-fixed: 100;
        }

        /* Responsive typography */
        @media screen and (min-width: 968px) {
            :root {
                --big-font-size: 3.5rem;
                --h1-font-size: 2.25rem;
                --h2-font-size: 1.5rem;
                --h3-font-size: 1.25rem;
                --normal-font-size: 1rem;
                --small-font-size: 0.875rem;
                --smaller-font-size: 0.813rem;
            }
        }

        /*=============== BASE ===============*/
        * {
            box-sizing: border-box;
            padding: 0;
            margin: 0;
        }

        html {
            scroll-behavior: smooth;
        }

        body,
        button,
        input,
        textarea {
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
        }

        body {
            margin: var(--header-height) 0 0 0;
            background-color: var(--body-color);
            color: var(--text-color);
            transition: 0.4s; /*For animation dark mode*/
        }

        button {
            cursor: pointer;
            border: none;
            outline: none;
        }

        h1,
        h2,
        h3 {
            color: var(--title-color);
            font-weight: var(--font-semi-bold);
        }

        ul {
            list-style: none;
        }

        a {
            text-decoration: none;
        }

        img {
            max-width: 100%;
            height: auto;
        }

        /*=============== THEME ===============*/
        /*========== Variables Dark theme ==========*/
        body.dark-theme {
            --first-color-dark: hsl(var(--hue), 8%, 20%);
            --title-color: hsl(var(--hue), 4%, 95%);
            --text-color: hsl(var(--hue), 4%, 75%);
            --body-color: hsl(var(--hue), 8%, 12%);
            --container-color: hsl(var(--hue), 8%, 16%);
        }

        /*========== Button Dark/Light ==========*/
        .change-theme {
            color: var(--title-color);
            font-size: 1.15rem;
            cursor: pointer;
        }

        .nav__btns {
            display: inline-flex;
            align-items: center;
            column-gap: 1rem;
        }

        /*==========
        Color changes in some parts of
        the website, in dark theme
        ==========*/

        .dark-theme .steps__bg,
        .dark-theme .questions {
            background-color: var(--first-color-dark);
        }

        .dark-theme .product__circle,
        .dark-theme .footer__subscribe {
            background-color: var(--container-color);
        }

        .dark-theme .scroll-header {
            box-shadow: 0 1px 4px hsla(var(--hue), 4%, 4%, 0.3);
        }

        /*=============== REUSABLE CSS CLASSES ===============*/
        .section {
            padding: 5.5rem 0 1rem;
        }

        .section__title,
        .section__title-center {
            font-size: var(--h2-font-size);
            margin-bottom: var(--mb-2);
            line-height: 140%;
        }

        .section__title-center {
            text-align: center;
        }

        .container {
            max-width: 968px;
            margin-left: var(--mb-1-5);
            margin-right: var(--mb-1-5);
        }

        .grid {
            display: grid;
        }

        .main {
            overflow: hidden; /*For animation*/
        }

        /*=============== HEADER ===============*/
        .header {
            width: 100%;
            background-color: var(--body-color);
            position: fixed;
            top: 0;
            left: 0;
            z-index: var(--z-fixed);
            transition: 0.4s; /*For animation dark mode*/
        }

        /*=============== NAV ===============*/
        .nav {
            height: var(--header-height);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav__logo,
        .nav__toggle,
        .nav__close {
            color: var(--title-color);
        }

        .nav__logo {
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: -1px;
            display: inline-flex;
            align-items: center;
            column-gap: 0.5rem;
            transition: 0.3s;
        }

        .nav__logo-icon {
            font-size: 1.15rem;
            color: var(--first-color);
        }

        .nav__logo:hover {
            color: var(--first-color);
        }

        .nav__toggle {
            display: inline-flex;
            font-size: 1.25rem;
            cursor: pointer;
        }

        @media screen and (max-width: 767px) {
            .nav__menu {
                position: fixed;
                background-color: var(--container-color);
                width: 80%;
                height: 100%;
                top: 0;
                right: -100%;
                box-shadow: -2px 0 4px hsla(var(--hue), 24%, 15%, 0.1);
                padding: 4rem 0 0 3rem;
                border-radius: 1rem 0 0 1rem;
                transition: 0.3s;
                z-index: var(--z-fixed);
            }
        }

        .nav__close {
            font-size: 1.5rem;
            position: absolute;
            top: 1rem;
            right: 1.25rem;
            cursor: pointer;
        }

        .nav__list {
            display: flex;
            flex-direction: column;
            row-gap: 1.5rem;
        }

        .nav__link {
            color: var(--title-color);
            font-weight: var(--font-medium);
            transition: 0.3s;
        }

        .nav__link:hover {
            color: var(--first-color);
        }

        /* Show menu */
        .show-menu {
            right: 0;
        }

        /* Change background header */
        .scroll-header {
            box-shadow: 0 1px 4px hsla(var(--hue), 4%, 15%, 0.1);
        }

        /* Active link */
        .active-link {
            position: relative;
            color: var(--first-color);
        }

        .active-link::after {
            content: "";
            position: absolute;
            bottom: -0.5rem;
            left: 0;
            width: 50%;
            height: 2px;
            background-color: var(--first-color);
        }

        /*=============== HOME ===============*/
        .home {
            padding: 3.5rem 0 2rem;
        }

        .home__container {
            position: relative;
            row-gap: 2rem;
        }

        .home__img {
            width: 200px;
            justify-self: center;
        }

        .home__title {
            font-size: var(--big-font-size);
            line-height: 140%;
            margin-bottom: var(--mb-1);
        }

        .home__description {
            margin-bottom: var(--mb-2-5);
        }

        .home__social {
            position: absolute;
            top: 2rem;
            right: -1rem;
            display: grid;
            justify-items: center;
            row-gap: 3.5rem;
        }

        .home__social-follow {
            font-weight: var(--font-medium);
            font-size: var(--smaller-font-size);
            color: var(--first-color);
            position: relative;
            transform: rotate(90deg);
        }

        .home__social-follow::after {
            content: "";
            position: absolute;
            width: 1rem;
            height: 2px;
            background-color: var(--first-color);
            right: -45%;
            top: 50%;
        }

        .home__social-links {
            display: inline-flex;
            flex-direction: column;
            row-gap: 0.25rem;
        }

        .home__social-link {
            font-size: 1rem;
            color: var(--first-color);
            transition: 0.3s;
        }

        .home__social-link:hover {
            transform: translateX(0.25rem);
        }

        /*=============== BUTTONS ===============*/
        .button {
            display: inline-block;
            background-color: var(--first-color);
            color: #fff;
            padding: 1rem 1.75rem;
            border-radius: 0.5rem;
            font-weight: var(--font-medium);
            transition: 0.3s;
        }

        .button:hover {
            background-color: var(--first-color-alt);
        }

        .button__icon {
            transition: 0.3s;
        }

        .button:hover .button__icon {
            transform: translateX(0.25rem);
        }

        .button--flex {
            display: inline-flex;
            align-items: center;
            column-gap: 0.5rem;
        }

        .button--link {
            color: var(--first-color);
            font-weight: var(--font-medium);
        }

        .button--link:hover .button__icon {
            transform: translateX(0.25rem);
        }

        /*=============== ABOUT ===============*/
        .about__container {
            row-gap: 2rem;
        }

        .about__img {
            width: 280px;
            justify-self: center;
        }

        .about__title {
            margin-bottom: var(--mb-1);
        }

        .about__description {
            margin-bottom: var(--mb-2);
        }

        .about__details {
            display: grid;
            row-gap: 1rem;
            margin-bottom: var(--mb-2-5);
        }

        .about__details-description {
            display: inline-flex;
            column-gap: 0.5rem;
            font-size: var(--small-font-size);
        }

        .about__details-icon {
            font-size: 1rem;
            color: var(--first-color);
            margin-top: 0.15rem;
        }

        /*=============== STEPS ===============*/
        .steps__bg {
            background-color: var(--first-color);
            padding: 3rem 2rem 2rem;
            border-radius: 1rem;
        }

        .steps__container {
            gap: 2rem;
            padding-top: 1rem;
        }

        .steps__title {
            color: #fff;
        }

        .steps__card {
            background-color: var(--container-color);
            padding: 2.5rem 3rem 2rem 1.5rem;
            border-radius: 1rem;
        }

        .steps__card-number {
            display: inline-block;
            background-color: var(--first-color-alt);
            color: #fff;
            padding: 0.5rem 0.75rem;
            border-radius: 0.25rem;
            font-size: var(--h2-font-size);
            margin-bottom: var(--mb-1-5);
            transition: 0.3s;
        }

        .steps__card-title {
            font-size: var(--h3-font-size);
            margin-bottom: var(--mb-0-5);
        }

        .steps__card-description {
            font-size: var(--small-font-size);
        }

        .steps__card:hover .steps__card-number {
            transform: translateY(-0.25rem);
        }

        /*=============== PRODUCTS ===============*/
        .product__description {
            text-align: center;
        }

        .product__container {
            padding: 3rem 0;
            grid-template-columns: repeat(2, 1fr);
            gap: 2.5rem 3rem;
        }

        .product__card {
            display: grid;
            position: relative;
        }

        .product__img {
            position: relative;
            width: 120px;
            justify-self: center;
            margin-bottom: var(--mb-0-75);
            transition: 0.3s;
        }

        .product__title,
        .product__price {
            font-size: var(--small-font-size);
            font-weight: var(--font-semi-bold);
            color: var(--title-color);
        }

        .product__title {
            margin-bottom: 0.25rem;
        }

        .product__button {
            position: absolute;
            right: 0;
            bottom: 0;
            background-color: var(--first-color);
            color: #fff;
            padding: 0.25rem;
            border-radius: 0.35rem;
            font-size: 1.15rem;
        }

        .product__button:hover {
            background-color: var(--first-color-alt);
        }

        .product__circle {
            width: 90px;
            height: 90px;
            background-color: var(--first-color-lighten);
            border-radius: 50%;
            position: absolute;
            top: 18%;
            left: 5%;
        }

        .product__card:hover .product__img {
            transform: translateY(-0.5rem);
        }

        /*=============== QUESTIONS ===============*/
        .questions {
            background-color: var(--first-color-lighten);
        }

        .questions__container {
            gap: 1.5rem;
            padding: 1.5rem 0;
        }

        .questions__group {
            display: grid;
            row-gap: 1.5rem;
        }

        .questions__item {
            background-color: var(--container-color);
            border-radius: 0.25rem;
        }

        .questions__item-title {
            font-size: var(--small-font-size);
            font-weight: var(--font-medium);
        }

        .questions__icon {
            font-size: 1.25rem;
            color: var(--title-color);
        }

        .questions__description {
            font-size: var(--smaller-font-size);
            padding: 0 1.25rem 1.25rem 2.5rem;
        }

        .questions__header {
            display: flex;
            align-items: center;
            column-gap: 0.5rem;
            padding: 0.75rem 0.5rem;
            cursor: pointer;
        }

        .questions__content {
            overflow: hidden;
            height: 0;
        }

        .questions__item,
        .questions__header,
        .questions__item-title,
        .questions__icon,
        .questions__description,
        .questions__content {
            transition: 0.3s;
        }

        .questions__item:hover {
            box-shadow: 0 2px 8px hsla(var(--hue), 4%, 15%, 0.15);
        }

        /*Rotate icon, change color of titles and background*/
        .accordion-open .questions__header,
        .accordion-open .questions__content {
            background-color: var(--first-color);
        }

        .accordion-open .questions__item-title,
        .accordion-open .questions__description,
        .accordion-open .questions__icon {
            color: #fff;
        }

        .accordion-open .questions__icon {
            transform: rotate(45deg);
        }

        /*=============== CONTACT ===============*/
        .contact__container {
            row-gap: 3.5rem;
        }

        .contact__data {
            display: grid;
            row-gap: 2rem;
        }

        .contact__subtitle {
            font-size: var(--normal-font-size);
            font-weight: var(--font-medium);
            color: var(--text-color);
            margin-bottom: var(--mb-0-5);
        }

        .contact__description {
            display: inline-flex;
            align-items: center;
            column-gap: 0.5rem;
            color: var(--title-color);
            font-weight: var(--font-medium);
        }

        .contact__icon {
            font-size: 1.25rem;
        }

        .contact__inputs {
            display: grid;
            row-gap: 2rem;
            margin-bottom: var(--mb-2-5);
        }

        .contact__content {
            position: relative;
            height: 3rem;
            border-bottom: 1px solid var(--text-color-light);
        }

        .contact__input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 1rem 1rem 1rem 0;
            background: none;

            color: var(--text-color);

            border: none;
            outline: none;
            z-index: 1;
        }

        .contact__label {
            position: absolute;
            top: 0.75rem;
            width: 100%;
            font-size: var(--small-font-size);
            color: var(--text-color-light);
            transition: 0.3s;
        }

        .contact__area {
            height: 7rem;
        }

        .contact__area textarea {
            resize: none;
        }

        /*Input focus move up label*/
        .contact__input:focus + .contact__label {
            top: -0.75rem;
            left: 0;
            font-size: var(--smaller-font-size);
            z-index: 10;
        }

        /*Input focus sticky top label*/
        .contact__input:not(:placeholder-shown).contact__input:not(:focus)
        + .contact__label {
            top: -0.75rem;
            font-size: var(--smaller-font-size);
            z-index: 10;
        }

        /*=============== FOOTER ===============*/
        .footer__container {
            row-gap: 3rem;
        }

        .footer__logo {
            display: inline-flex;
            align-items: center;
            column-gap: 0.5rem;
            color: var(--title-color);
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: -1px;
            margin-bottom: var(--mb-2-5);
            transition: 0.3s;
        }

        .footer__logo-icon {
            font-size: 1.15rem;
            color: var(--first-color);
        }

        .footer__logo:hover {
            color: var(--first-color);
        }

        .footer__title {
            font-size: var(--h3-font-size);
            margin-bottom: var(--mb-1-5);
        }

        .footer__subscribe {
            background-color: var(--first-color-lighten);
            padding: 0.75rem;
            display: flex;
            justify-content: space-between;
            border-radius: 0.5rem;
        }

        .footer__input {
            width: 70%;
            padding: 0 0.5rem;
            background: none;
            color: var(--text-color);
            border: none;
            outline: none;
        }

        .footer__button {
            padding: 1rem;
        }

        .footer__data {
            display: grid;
            row-gap: 0.75rem;
        }

        .footer__information {
            font-size: var(--small-font-size);
        }

        .footer__social {
            display: inline-flex;
            column-gap: 0.75rem;
        }

        .footer__social-link {
            font-size: 1rem;
            color: var(--text-color);
            transition: 0.3s;
        }

        .footer__social-link:hover {
            transform: translateY(-0.25rem);
        }

        .footer__cards {
            display: inline-flex;
            align-items: center;
            column-gap: 0.5rem;
        }
        .footer__card {
            width: 35px;
        }

        .footer__copy {
            text-align: center;
            font-size: var(--smaller-font-size);
            color: var(--text-color-light);
            margin: 5rem 0 1rem;
        }

        /*=============== SCROLL UP ===============*/
        .scrollup {
            position: fixed;
            background-color: var(--first-color);
            right: 1rem;
            bottom: -30%;
            display: inline-flex;
            padding: 0.5rem;
            border-radius: 0.25rem;
            z-index: var(--z-tooltip);
            opacity: 0.8;
            transition: 0.4s;
        }

        .scrollup__icon {
            font-size: 1rem;
            color: #fff;
        }

        .scrollup:hover {
            background-color: var(--first-color-alt);
            opacity: 1;
        }

        /* Show Scroll Up*/
        .show-scroll {
            bottom: 3rem;
        }

        /*=============== SCROLL BAR ===============*/
        ::-webkit-scrollbar {
            width: 0.6rem;
            background: hsl(var(--hue), 4%, 53%);
        }

        ::-webkit-scrollbar-thumb {
            background: hsl(var(--hue), 4%, 29%);
            border-radius: 0.5rem;
        }

        /*=============== BREAKPOINTS ===============*/
        /* For small devices */
        @media screen and (max-width: 320px) {
            .container {
                margin-left: var(--mb-1);
                margin-right: var(--mb-1);
            }

            .home__img {
                width: 180px;
            }
            .home__title {
                font-size: var(--h1-font-size);
            }

            .steps__bg {
                padding: 2rem 1rem;
            }
            .steps__card {
                padding: 1.5rem;
            }

            .product__container {
                grid-template-columns: 0.6fr;
                justify-content: center;
            }
        }

        /* For medium devices */
        @media screen and (min-width: 576px) {
            .steps__container {
                grid-template-columns: repeat(2, 1fr);
            }

            .product__description {
                padding: 0 4rem;
            }
            .product__container {
                grid-template-columns: repeat(2, 170px);
                justify-content: center;
                column-gap: 5rem;
            }

            .footer__subscribe {
                width: 400px;
            }
        }

        @media screen and (min-width: 767px) {
            body {
                margin: 0;
            }

            .nav {
                height: calc(var(--header-height) + 1.5rem);
                column-gap: 3rem;
            }
            .nav__toggle,
            .nav__close {
                display: none;
            }
            .nav__list {
                flex-direction: row;
                column-gap: 3rem;
            }
            .nav__menu {
                margin-left: auto;
            }

            .home__container,
            .about__container,
            .questions__container,
            .contact__container,
            .footer__container {
                grid-template-columns: repeat(2, 1fr);
            }

            .home {
                padding: 10rem 0 5rem;
            }
            .home__container {
                align-items: center;
            }
            .home__img {
                width: 280px;
                order: 1;
            }
            .home__social {
                top: 30%;
            }

            .questions__container {
                align-items: flex-start;
            }

            .footer__container {
                column-gap: 3rem;
            }
            .footer__subscribe {
                width: initial;
            }
        }

        /* For large devices */
        @media screen and (min-width: 992px) {
            .container {
                margin-left: auto;
                margin-right: auto;
            }

            .section {
                padding: 8rem 0 1rem;
            }
            .section__title,
            .section__title-center {
                font-size: var(--h1-font-size);
            }

            .home {
                padding: 13rem 0 5rem;
            }
            .home__img {
                width: 350px;
            }
            .home__description {
                padding-right: 7rem;
            }

            .about__img {
                width: 380px;
            }

            .steps__container {
                grid-template-columns: repeat(3, 1fr);
            }
            .steps__bg {
                padding: 3.5rem 2.5rem;
            }
            .steps__card-title {
                font-size: var(--normal-font-size);
            }

            .product__description {
                padding: 0 16rem;
            }
            .product__container {
                padding: 4rem 0;
                grid-template-columns: repeat(3, 185px);
                gap: 4rem 6rem;
            }
            .product__img {
                width: 160px;
            }
            .product__circle {
                width: 110px;
                height: 110px;
            }
            .product__title,
            .product__price {
                font-size: var(--normal-font-size);
            }

            .questions__container {
                padding: 1rem 0 4rem;
            }
            .questions__title {
                text-align: initial;
            }
            .questions__group {
                row-gap: 2rem;
            }
            .questions__header {
                padding: 1rem;
            }
            .questions__description {
                padding: 0 3.5rem 2.25rem 2.75rem;
            }

            .footer__logo {
                font-size: var(--h3-font-size);
            }
            .footer__container {
                grid-template-columns: 1fr 0.5fr 0.5fr 0.5fr;
            }
            .footer__copy {
                margin: 7rem 0 2rem;
            }
        }

        @media screen and (min-width: 1200px) {
            .home__social {
                right: -3rem;
                row-gap: 4.5rem;
            }
            .home__social-follow {
                font-size: var(--small-font-size);
            }
            .home__social-follow::after {
                width: 1.5rem;
                right: -60%;
            }
            .home__social-link {
                font-size: 1.15rem;
            }

            .about__container {
                column-gap: 7rem;
            }

            .scrollup {
                right: 3rem;
            }
        }
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("img/img.png");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0.8;
            z-index: -1;
        }

        /*header {*/
        /*    background-color: #578E7E;*/
        /*    padding: 15px;*/
        /*    text-align: center;*/
        /*    color: #fff;*/
        /*    font-size: 24px;*/
        /*}*/
        .categories-container {
            max-width: 1200px;
            /*margin-top: 100px;*/
            margin: 100px auto;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .category-card {
            width: 250px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .category-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .category-card h3 {
            margin: 15px 0;
            font-size: 18px;
            color: #333;
        }
        .category-card a {
            display: inline-block;
            margin-bottom: 15px;
            padding: 10px 20px;
            font-size: 14px;
            color: #fff;
            background-color: #578E7E;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        .category-card a:hover {
            background-color: #457062;
        }
    </style>
</head>
<body>
<!--==================== HEADER ====================-->
<header class="header" id="header">
    <nav class="nav container">
        <a href="#" class="nav__logo">
            <i class="ri-leaf-line nav__logo-icon"></i> Plantex
        </a>

        <div class="nav__menu" id="nav-menu">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="customer-dashboard.jsp" class="nav__link active-link">Home</a>
                </li>
<%--                <li class="nav__item">--%>
<%--                    <a href="#about" class="nav__link">About</a>--%>
<%--                </li>--%>
                <li class="nav__item">
                    <a href="customer-category" class="nav__link">Products</a>
                </li>
<%--                <li class="nav__item">--%>
<%--                    <a href="#faqs" class="nav__link">FAQs</a>--%>
<%--                </li>--%>
<%--                <li class="nav__item">--%>
<%--                    <a href="#contact" class="nav__link">Contact Us</a>--%>
<%--                </li>--%>
            </ul>

            <div class="nav__close" id="nav-close">
                <i class="ri-close-line"></i>
            </div>
        </div>

        <div class="nav__btns">
            <!-- Theme change button -->
            <i class="ri-moon-line change-theme" id="theme-button"></i>

            <div class="nav__toggle" id="nav-toggle">
                <i class="ri-menu-line"></i>
            </div>
        </div>
    </nav>
</header>


<main class="categories-container">
    <%
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
        if (categories != null && !categories.isEmpty()) {
            for (CategoryDTO category : categories) {
    %>
    <div class="category-card">
        <img src="<%= category.getId() %>" alt="<%= category.getName() %>">
        <h3><%= category.getName() %></h3>
        <a href="customer-product?categoryId=<%= category.getId() %>">Shop Now</a>
    </div>
    <%
        }
    } else {
    %>
    <p>No categories available at the moment.</p>
    <% } %>
</main>
</body>
</html>
