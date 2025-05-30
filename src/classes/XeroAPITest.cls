/**
* @author Ben Edwards (ben@edwards.nz)
* @date 3rd February 2020
* @description Test class for the Xero API
**/
@isTest
public class XeroAPITest {

    @isTest
    static void testGetContact() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroContactMock'));

        Test.startTest();

        XeroContact xeroContact = XeroAPI.getContact('ABC123');

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(xeroContact.ContactID),
            'Xero Contact ID should be loaded against the response.'
        );
    }

    @isTest
    static void testGetContacts() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroContactMock'));

        Test.startTest();

        XeroContact xeroContact = XeroAPI.getContacts()[0];

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(xeroContact.ContactID),
            'Xero Contact ID should be loaded against the response.'
        );
    }

    @isTest
    static void testSendContact() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroContactMock'));

        XeroContact myXeroContact = new XeroContact(
            new Account(
                Phone = '0800 SNOOPDOGG',
                BillingStreet = '1 Snoop Lane',
                ShippingStreet = '1 Snoop Lane'
            )
        );

        Test.startTest();

        myXeroContact = XeroAPI.sendContact(myXeroContact);

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(myXeroContact.ContactID),
            'Xero Contact ID should be loaded against the response.'
        );
    }

    @isTest
    static void getGetInvoice() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroInvoiceMock'));

        Test.startTest();

        XeroInvoice xeroInvoice = XeroAPI.getInvoice('ABC123');

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(xeroInvoice.InvoiceID),
            'Xero Invoice ID should be loaded against the response.'
        );
    }

    @isTest
    static void testGetInvoices() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroInvoiceMock'));

        Test.startTest();

        XeroInvoice xeroInvoice = XeroAPI.getInvoices()[0];

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(xeroInvoice.InvoiceID),
            'Xero Invoice ID should be loaded against the response.'
        );
    }

    @isTest
    static void testGetInvoicesWithDaysFilter() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroInvoiceMock'));

        Test.startTest();

        XeroInvoice xeroInvoice = XeroAPI.getInvoices(1)[0];

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(xeroInvoice.InvoiceID),
            'Xero Invoice ID should be loaded against the response.'
        );
    }

    @isTest
    static void testGetInvoiceAsPDF() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroInvoicePDFMock'));

        Test.startTest();

        Blob myInvoice = XeroAPI.getInvoiceAsPdf('ABC123');

        Test.stopTest();

        Assert.isNotNull(
            myInvoice,
            'Fake Invoice should be returned from API.'
        );
    }

    @isTest
    static void testSendInvoice() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroInvoiceMock'));

        XeroInvoice myXeroInvoice = new XeroInvoice('xeroContactId');

        Test.startTest();

        myXeroInvoice = XeroAPI.sendInvoice(myXeroInvoice);

        Test.stopTest();

        Assert.isFalse(
            String.isBlank(myXeroInvoice.InvoiceID),
            'Xero Invoice ID should be loaded against the response.'
        );
    }

    @istest
    static void testGetXeroTenantId() {

        // Set the Mock Class
        Test.setMock(HttpCalloutMock.class, setStaticMock('XeroConnectionsMock'));

        Test.startTest();

        Assert.isFalse(
            String.isBlank(XeroAPI.getXeroTenantId()),
            'Xero Tenant should be retrieved.'
        );

        Test.stopTest();
    }

    /**
    * @author Ben Edwards (ben@edwards.nz)
    * @date 3rd February 2020
    * @description Simple method to default mock classes for the Xero callout
    **/
    public static StaticResourceCalloutMock setStaticMock (String mockName) {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource(mockName);
		mock.setStatusCode(200);
		mock.setHeader('Content-Type', 'application/json');
		return mock;
    }
}
