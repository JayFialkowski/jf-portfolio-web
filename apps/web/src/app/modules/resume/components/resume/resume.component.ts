import {ChangeDetectionStrategy, Component} from '@angular/core';
import {ResumeSectionDetail} from '../../models';
import {Title} from '@angular/platform-browser';

@Component({
    templateUrl: './resume.component.html',
    styleUrls: ['./resume.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush
})

export class ResumeComponent {

    readonly resumeUrl: string = '/assets/jay_fialkowski_resume.pdf';

    readonly links = [
        {
            icon: 'telephone-fill',
            label: '(716) 866-2199',
            href: 'tel:7168662199'
        },
        {
            icon: 'envelope-fill',
            label: 'jayfialkowski@me.com',
            href: 'mailto:jayfialkowski@me.com'
        },
        {
            icon: 'github',
            label: 'www.github.com/JayFialkowski',
            href: 'https://github.com/jayfialkowski'
        },
        {
            icon: 'linkedin',
            label: 'www.linkedin.com/in/jayfialkowski',
            href: 'https://linkedin.com/in/jayfialkowski'
        }
    ];

    readonly sections: ResumeSectionDetail[] = [
        // captech experience
        {
            title: 'CapTech Consulting',
            items: [
                {
                    title: 'Capital One',
                    timeline: 'October 2020 - Present',
                    list: [
                        'Designed the architecture for a data insights application, leveraging Micro Front End patterns and modern Web Components',
                        'Ensured high testing coverage, code quality, code coverage, and WCAG compliance',
                        'Implemented custom reusable components and tools',
                        'Facilitated CI/CD process of front end components, including cache-busting and load balancing via AWS'
                    ],
                    tools: ['Micro Front End', 'TypeScript', 'LitElement', 'SCSS', 'Jest', 'Artifactory', 'SonarQube', 'Jenkins', 'AWS', 'Terraform']
                },
                {
                    title: 'Markel',
                    timeline: 'March 2020 - October 2020',
                    list: [
                        'Implement reusable renderings for content authors to leverage while building SiteCore site',
                        'Ensure highly tested and WCAG compliant design implementations'

                    ],
                    tools: ['SiteCore', 'SCSS']
                },
                {
                    title: 'Shutterfly',
                    timeline: 'December 2018 - March 2020',
                    list: [
                        'Working alongside a large team to modernize the client’s production platform technology. This includes all workflows and services surrounding their order fulfillment processes nationally',
                        'Implemented most services as AWS Lambdas, and others as Java Spring applications where necessary – all written using Java 11. Front End applications are built using Angular 7, and all data persistence uses Postgres',
                        'Contributing to implementation of CI/CD pipeline, using tools such as Docker, Jenkins Pipeline, SonarQube, Terraform, and Artifactory',
                        'Responsible for supervision of all Front End development by teams spanning across three cities'
                    ],
                    tools: ['Angular', 'Terraform', 'SCSS', 'AWS', 'Jenkins', 'SonarQube', 'Artifactory', 'jasmine', 'i18n', 'Postgres']
                },
                {
                    title: 'Premier',
                    timeline: 'October 2017 - December 2018',
                    list: [
                        'Assisted with the rewrite of several of the client’s legacy applications. As a developer, participated in the team’s Agile workflow and contributed too all aspects of the project’s technology stack',
                        'The primary tools utilized were Angular 6 for the front end, Spring Framework for RESTful service, and Postgres for data persistence',
                        'Other tools included Liquibase for schema versioning, as well Bamboo and SonarQube in the development pipeline'
                    ],
                    tools: ['Angular', 'jasmine', 'SCSS', 'Java Spring', 'Bamboo', 'Postgres', 'SonarQube', 'Liquibase']
                },
                {
                    title: 'Manhattan Associates',
                    timeline: 'April 2017 - October 2017',
                    list: [
                        'At this client, I was tasked with designing and implementing responsive and reusable UI components, to be distributed across multiple platforms and devices',
                        'Using modern technologies such as Ionic and Cordova, I assisted with developing a platform-agnostic application which could be utilized on mobile, tablet, and desktop environments',
                        'In this endeavor, I was sure to build components which were well tested, documented, and compatible with the native library via extension'
                    ],
                    tools: [
                        'Ionic', 'Cordova', 'jasmine', 'SCSS'
                    ]
                }
            ]
        },
        // education
        {
            title: 'Education',
            items: [
                {
                    title: 'University at Buffalo',
                    timeline: '2011 - 2015',
                    list: [
                        'Bachelor of Science in Computer Science, minor in Management'
                    ]
                }
            ]
        }
    ];

    constructor(private readonly title: Title) {
        title.setTitle('Jay Fialkowski - Resume');
    }
}
